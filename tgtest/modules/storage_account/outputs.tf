
output "id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.st.id
}

output "name" {
  description = "The name of the storage account."
  value       = azurerm_storage_account.st.name
}

output "resource_group_name" {
  description = "The name of the resource group where the storage account is created."
  value       = azurerm_storage_account.st.resource_group_name
}

output "primary_location" {
  description = "The primary location of the storage account"
  value       = azurerm_storage_account.st.primary_location
}

output "secondary_location" {
  description = "The secondary location of the storage account"
  value       = azurerm_storage_account.st.secondary_location
}

output "primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location"
  value       = azurerm_storage_account.st.primary_blob_endpoint
}

output "secondary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the secondary location."
  value       = azurerm_storage_account.st.secondary_blob_endpoint
}

output "primary_connection_string" {
  description = "The connection string associated with the primary location"
  value       = azurerm_storage_account.st.primary_connection_string
}

output "secondary_connection_string" {
  description = "The connection string associated with the secondary location"
  value       = azurerm_storage_account.st.secondary_connection_string
}

output "primary_blob_connection_string" {
  description = "The connection string associated with the primary blob location"
  value       = azurerm_storage_account.st.primary_blob_connection_string
}

output "secondary_blob_connection_string" {
  description = "The connection string associated with the secondary blob location"
  value       = azurerm_storage_account.st.secondary_blob_connection_string
}

output "primary_access_key" {
  value = azurerm_storage_account.st.primary_access_key
}

output "secondary_access_key" {
  value = azurerm_storage_account.st.secondary_access_key
}

output "management_policy_id" {
  description = "The ID of the Storage Account Management Policy."
  value       = module.lifecycle_management_rules.*.management_policy_id
}