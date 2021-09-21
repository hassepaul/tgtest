
output "id" {
  value       = azurerm_security_center_automation.sca.*.id
  description = "The id of the service_center automation"
}
