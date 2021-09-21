# Terraform specific settings
# Naming

module "naming" {
  source = "../../../modules/naming"
  suffix = var.suffix
}

#########################################
#
#   Storage account setup for primary db: Server auditing and vulnerability assessment
#   If failover is enabled - create an SA for the secondary server too
#
#########################################

#module "primary_sa" {
#  source                   = "../../../modules/storage_account"
#  suffix                   = var.sa_name
#  resource_group_name      = var.resource_group_name
#  location                 = var.location
#  account_replication_type = var.sa_replication_type
#  tags                     = var.tags
#}

#########################################
#
#   Server setup - primary and if failover is enabled, create the secondary
#
#########################################

resource "azurerm_mssql_server" "primary" {
  name                          = module.naming.mssql_server.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.server_version
  administrator_login           = var.admin_user
  administrator_login_password  = var.password
  minimum_tls_version           = var.minimum_tls
  public_network_access_enabled = var.public_network_access_enabled
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags

  dynamic "azuread_administrator" {
    for_each = try(var.administrator, null) == null ? [] : [1]

    content {
      login_username = var.administrator.login_username
      object_id      = data.azuread_user.mssql_admin[0].id
    }
  }
}

#########################################
#
#   Extended audit policy - create the audit policy for the primary server
#
#########################################

resource "azurerm_role_assignment" "ra" {
  scope                = var.sa_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_mssql_server.primary.identity.0.principal_id
}

resource "azurerm_mssql_server_extended_auditing_policy" "primary_audit" {
  depends_on = [azurerm_role_assignment.ra]

  server_id         = azurerm_mssql_server.primary.id
  storage_endpoint  = var.sa_primary_blob_endpoint
  retention_in_days = var.retention_days
}

#########################################
#
#   Private endpoint creation for the primary server
#   and if failover is enabled, create a private endpoint for the secondary server
#
#########################################

resource "azurerm_private_endpoint" "primary-pe" {
  count               = var.subnet_id != null ? 1 : 0
  name                = "pe-${azurerm_mssql_server.primary.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id

  dynamic "private_dns_zone_group" {
    for_each = length(var.private_dns_zone_ids) != 0 ? [1] : []

    content {
      name                 = "pdnszg-${azurerm_mssql_server.primary.name}"
      private_dns_zone_ids = var.private_dns_zone_ids
    }
  }

  private_service_connection {
    name                           = module.naming.private_service_connection.name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mssql_server.primary.id
    subresource_names              = ["sqlServer"]
  }

  tags = var.tags
}
