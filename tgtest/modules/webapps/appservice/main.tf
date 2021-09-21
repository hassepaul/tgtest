
# Naming convention
module "naming" {
  source = "../../naming"
  suffix = var.suffix
}

resource "azurerm_app_service" "web_app" {
  name                    = module.naming.app_service.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  tags                    = var.tags

  app_service_plan_id     = var.app_service_plan_id
  client_affinity_enabled = var.client_affinity_enabled
  client_cert_enabled     = var.client_cert_enabled
  enabled                 = var.enabled
  https_only              = var.https_only
  app_settings            = local.app_settings

  dynamic "site_config" {
    for_each = var.site_config != {} ? [1] : []

    content {
      always_on                 = try(var.site_config.always_on, false)
      app_command_line          = try(var.site_config.app_command_line, null)
      default_documents         = try(var.site_config.default_documents, null)
      dotnet_framework_version  = try(var.site_config.dotnet_framework_version, null)
      ftps_state                = try(var.site_config.ftps_state, "FtpsOnly")
      http2_enabled             = try(var.site_config.http2_enabled, false)
      java_version              = try(var.site_config.java_version, null)
      java_container            = try(var.site_config.java_container, null)
      java_container_version    = try(var.site_config.java_container_version, null)
      local_mysql_enabled       = try(var.site_config.local_mysql_enabled, null)
      linux_fx_version          = try(var.site_config.linux_fx_version, null)
      windows_fx_version        = try(var.site_config.windows_fx_version, null)
      managed_pipeline_mode     = try(var.site_config.managed_pipeline_mode, null)
      min_tls_version           = try(var.site_config.min_tls_version, "1.2")
      php_version               = try(var.site_config.php_version, null)
      python_version            = try(var.site_config.python_version, null)
      remote_debugging_enabled  = try(var.site_config.remote_debugging_enabled, null)
      remote_debugging_version  = try(var.site_config.remote_debugging_version, null)
      use_32_bit_worker_process = try(var.site_config.use_32_bit_worker_process, false)
      websockets_enabled        = try(var.site_config.websockets_enabled, false)
      scm_type                  = try(var.site_config.scm_type, "VSTSRM")
    }
  }

  dynamic "backup" {
    for_each = var.backup != {} ? [1] : []

    content {
      name                = "${module.naming.app_service.name}_backup"
      enabled             = try(var.backup.enable, true)
      storage_account_url = try(var.backup.storage_account_sas_url, local.backup_sas_url)

      dynamic "schedule" {
        for_each = try(var.backup.schedule, {}) != {} ? [1] : []

        content {
          frequency_interval       = var.backup.schedule.frequency_interval
          frequency_unit           = try(var.backup.schedule.frequency_unit, null)
          keep_at_least_one_backup = try(var.backup.schedule.keep_at_least_one_backup, null)
          retention_period_in_days = try(var.backup.schedule.retention_period_in_days, null)
          start_time               = try(var.backup.schedule.start_time, null)
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [app_settings, site_config["scm_type"], ]
  }

}

resource "azurerm_app_service_virtual_network_swift_connection" "web_app_vnet_integration" {
  count          = var.subnet_id != null ? 1 : 0
  app_service_id = azurerm_app_service.web_app.id
  subnet_id      = var.subnet_id
}

resource "azurerm_private_endpoint" "pe" {
  count               = var.private_inbound != {} ? 1 : 0
  name                = "pe-${azurerm_app_service.web_app.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.private_inbound.subnet_id

  dynamic "private_dns_zone_group" {
    for_each = length(var.private_inbound.private_dns_zone_ids) != 0 ? [1] : []

    content {
      name                 = "pdnszg-${azurerm_app_service.web_app.name}"
      private_dns_zone_ids = var.private_inbound.private_dns_zone_ids
    }
  }

  private_service_connection {
    name                           = module.naming.private_service_connection.name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_app_service.web_app.id
    subresource_names              = var.private_inbound.private_endpoint_subresources
  }

}
