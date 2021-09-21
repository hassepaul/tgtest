
output functionapp_id {
  value       = azurerm_function_app.fun.id
  description = "The Function App ID"
}

output principal_id {
  value       = var.function_app_system_identity_enabled ? azurerm_function_app.fun.identity[0].principal_id : ""
  description = "The Service Principal ID for the Function App"
}