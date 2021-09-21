
# Naming convention
module "naming" {
  source = "../../naming"
  suffix = var.name
}

resource "azurerm_function_app" "fun" {
  name                       = module.naming.function_app.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  version                    = var.function_app_version
  https_only                 = var.function_app_https_only
  client_affinity_enabled    = var.function_app_client_affinity_enabled
  enabled                    = var.function_app_enabled
  daily_memory_time_quota    = var.function_app_daily_memory_time_quota

  app_settings = local.app_settings

  site_config {
    always_on       = var.function_app_site_config_always_on
    min_tls_version = var.function_app_site_config_min_tls_version
    ftps_state      = var.function_app_site_config_ftps_state
    //scm_type        = var.function_app_site_config_scm_type  # Check this https://github.com/terraform-providers/terraform-provider-azurerm/issues/8171
  }

  dynamic "identity" {
    for_each = var.function_app_system_identity_enabled == true ? [1] : []

    content {
      type = "SystemAssigned"
    }
  }

  dynamic "auth_settings" {
    for_each = var.function_app_ad_auth_settings != null ? [1] : []

    content {
      enabled                       = true
      issuer                        = lookup(var.function_app_ad_auth_settings, "issuer_tenant_id", "") != "" ? "https://sts.windows.net/${var.function_app_ad_auth_settings.issuer_tenant_id}/" : null
      unauthenticated_client_action = "RedirectToLoginPage"
      default_provider              = lookup(var.function_app_ad_auth_settings, "default_provider", "") != "" ? var.function_app_ad_auth_settings.default_provider : "AzureActiveDirectory"
      active_directory {
        client_id         = lookup(var.function_app_ad_auth_settings, "client_id", "") != "" ? var.function_app_ad_auth_settings.client_id : null
        allowed_audiences = lookup(var.function_app_ad_auth_settings, "allowed_audiences", []) != [] ? var.function_app_ad_auth_settings.allowed_audiences : null
      }
    }
  }

  lifecycle {
    ignore_changes = [app_settings, ]
  }

  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "function_app_vnet_integration" {
  count          = var.subnet_id != null ? 1 : 0
  app_service_id = azurerm_function_app.fun.id
  subnet_id      = var.subnet_id
}

resource "azurerm_private_endpoint" "pe" {
  count               = var.private_inbound != {} ? 1 : 0
  name                = "pe-${azurerm_function_app.fun.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.private_inbound.subnet_id

  dynamic "private_dns_zone_group" {
    for_each = length(var.private_inbound.private_dns_zone_ids) != 0 ? [1] : []

    content {
      name                 = "pdnszg-${azurerm_function_app.fun.name}"
      private_dns_zone_ids = var.private_inbound.private_dns_zone_ids
    }
  }

  private_service_connection {
    name                           = module.naming.private_service_connection.name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_function_app.fun.id
    subresource_names              = var.private_inbound.private_endpoint_subresources
  }

}
