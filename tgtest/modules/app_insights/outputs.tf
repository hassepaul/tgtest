
output "appinsight_id" {
  value = azurerm_application_insights.ain.id
}

output "instrumentation_key" {
  value = azurerm_application_insights.ain.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.ain.app_id
}

output "connection_string" {
  value     = azurerm_application_insights.ain.connection_string
  sensitive = true
}