
module "naming" {
  source = "../../naming"
  suffix = var.suffix
}

# Setup MySQL Server
resource "azurerm_mysql_server" "db" {
  name                = module.naming.mysql_server.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  administrator_login          = try(var.server_config.admin_user, null)
  administrator_login_password = try(var.server_config.admin_password, null)

  sku_name   = try(var.server_config.sku_name, null)
  storage_mb = try(var.server_config.storage_mb, null)
  version    = try(var.server_config.version, null)

  auto_grow_enabled                 = try(var.server_config.auto_grow_enabled, true)
  backup_retention_days             = try(var.server_config.backup_retention_days, null)
  geo_redundant_backup_enabled      = try(var.server_config.geo_redundant_backup_enabled, null)
  infrastructure_encryption_enabled = try(var.server_config.infrastructure_encryption_enabled, false)
  public_network_access_enabled     = try(var.server_config.public_network_access_enabled, false)
  ssl_enforcement_enabled           = try(var.server_config.ssl_enforcement_enabled, true)
  ssl_minimal_tls_version_enforced  = try(var.server_config.ssl_minimal_tls_version_enforced, "TLS1_2")

  create_mode               = try(var.server_config.create_mode, null)
  creation_source_server_id = try(var.server_config.creation_source_server_id, null)
  restore_point_in_time     = try(var.server_config.restore_point_in_time, null)
}

# Setup MySQL parameters
resource "azurerm_mysql_configuration" "config" {
  for_each = local.mysql_config

  name                = each.key
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.db.name
  value               = each.value
}

# Setup Private Endpoint, if applies
resource "azurerm_private_endpoint" "db" {
  count               = try(var.subnet_id, null) != null ? 1 : 0
  name                = "pe-${azurerm_mysql_server.db.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id
  tags                = var.tags

  dynamic "private_dns_zone_group" {
    for_each = length(var.private_dns_zone_ids) != 0 ? [1] : []

    content {
      name                 = "pdnszg-${azurerm_mysql_server.db.name}"
      private_dns_zone_ids = var.private_dns_zone_ids
    }

  }

  private_service_connection {
    name                           = module.naming.private_service_connection.name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mysql_server.db.id
    subresource_names              = ["mysqlServer"]
  }
}
