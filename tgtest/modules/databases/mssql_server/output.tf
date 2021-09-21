output "server_id" {
  value = azurerm_mssql_server.primary.id
}

output "primary_mssql_server_fqdn" {
  value = azurerm_mssql_server.primary.fully_qualified_domain_name
}

output "sql_server_name" {
  description = "Name of the server created. Use this if more databases needs to be added to the server. "
  value       = azurerm_mssql_server.primary.name
}

output principal_id {
  value       = azurerm_mssql_server.primary.identity[0].principal_id
  description = "The Service Principal ID for the MSSQL Server"
}

# necessary to generate connection string at DB level
output "admin_user" {
  value     = var.admin_user
  sensitive = true
}

output "admin_password" {
  value     = var.password
  sensitive = true
}
