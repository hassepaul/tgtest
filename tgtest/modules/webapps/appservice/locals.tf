
locals {
  # Set default app settings and merge them with any others provided with the variable 
  vnet_outbound = { WEBSITE_VNET_ROUTE_ALL = 1 }
  default_dns   = { WEBSITE_DNS_SERVER = "168.63.129.16" }
  default_app   = { APPINSIGHTS_INSTRUMENTATIONKEY = var.app_insight_instrumentation_key }

  vnet_settings = var.custom_dns ? local.vnet_outbound : merge(local.vnet_outbound, local.default_dns)
  app_settings  = var.subnet_id != null ? merge(local.vnet_settings, local.default_app) : local.default_app

  # generate the SAS URL
  backup_sas_url = var.backup == {} ? null : "${var.backup.storage_account_primary_blob_endpoint}${var.backup.container_name}${data.azurerm_storage_account_blob_container_sas.backup[0].sas}"

}
