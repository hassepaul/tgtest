# OUTPUTS

#####################################
### PLACE YOUR OUTPUT VALUES HERE ###
#####################################

output "id" {
  description = "Id of the Key Vault"
  value       = azurerm_key_vault.keyvault.id
}

output "name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.keyvault.name
}

output "vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.keyvault.vault_uri
}