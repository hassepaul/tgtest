
# Naming convention
module "naming" {
  source = "../../naming"
  suffix = var.name
}

module "diagnostics" {
  source                  = "git::ssh://ProdNGAHR@vs-ssh.visualstudio.com/v3/ProdNGAHR/GT%20Cloud/tf-azurerm-mod-diagnostics-monitoring?ref=1.0.1"
  resource_name           = module.naming.key_vault.name
  diagnostics_map         = var.diagnostics_map
  log_analytics_workspace = var.log_analytics_workspace
  diagnostics_settings    = var.diagnostics_settings
  diagnostics_enabled     = var.diagnostics_enabled
  target_resource_id      = azurerm_key_vault.keyvault.id
}

# Deploy Key Vault
resource "azurerm_key_vault" "keyvault" {
  name                     = module.naming.key_vault.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  tenant_id                = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled = var.purge_protection
  sku_name                 = lower(var.sku)

  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment

  dynamic "access_policy" {
    for_each = local.user_access_policies_map

    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = data.azuread_user.ad_users[access_policy.value.user].id

      certificate_permissions = access_policy.value.certificate_permissions
      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions

    }
  }

  dynamic "access_policy" {
    for_each = local.group_access_policies_map

    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = data.azuread_group.ad_groups[access_policy.value.group].id

      certificate_permissions = access_policy.value.certificate_permissions
      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
    }
  }

  dynamic "access_policy" {
    for_each = local.app_access_policies_map

    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = data.azuread_service_principal.ad_apps[access_policy.value.app].object_id

      certificate_permissions = access_policy.value.certificate_permissions
      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions

    }
  }

  dynamic "network_acls" {
    for_each = var.network_acls == null ? [] : list(var.network_acls)

    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
    }
  }

  dynamic "network_acls" {
    for_each = var.network_acls == null ? [1] : []

    content {
      bypass         = "AzureServices"
      default_action = "Deny"
    }
  }

  tags = var.tags
}

resource "azurerm_key_vault_secret" "secret" {
  for_each = var.secrets

  name         = each.value.name
  value        = each.value.secret
  key_vault_id = azurerm_key_vault.keyvault.id

  lifecycle {
    ignore_changes = [ value ]
  }
}

# Deploy Private Endpoint (optional)
resource "azurerm_private_endpoint" "keyvault_pe" {
  count               = var.subnet_id != null ? 1 : 0
  name                = "pe-${azurerm_key_vault.keyvault.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id

  dynamic "private_dns_zone_group" {
    for_each = length(var.private_dns_zone_ids) != 0 ? [1] : []

    content {
      name                 = module.naming.private_dns_zone_group.name
      private_dns_zone_ids = var.private_dns_zone_ids
    }

  }

  private_service_connection {
    name                           = "psc-${azurerm_key_vault.keyvault.name}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    subresource_names              = ["vault"]
  }

  tags = var.tags
}
