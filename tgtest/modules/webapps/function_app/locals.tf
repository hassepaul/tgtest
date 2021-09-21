
locals {

  # Set default app settings and merge them with any others provided with the variable   
  default_vnet_integration_settings = {
    WEBSITE_VNET_ROUTE_ALL = 1
  }

  default_app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY        = var.app_insight_instrumentation_key
    FUNCTIONS_WORKER_RUNTIME              = var.function_app_setting_worker_runtime
    APPLICATIONINSIGHTS_CONNECTION_STRING = var.app_insight_connection_string
  }

  app_settings = var.subnet_id != null ? merge(local.default_vnet_integration_settings, local.default_app_settings, var.function_app_settings) : merge(local.default_app_settings, var.function_app_settings)
}