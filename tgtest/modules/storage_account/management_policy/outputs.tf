# OUTPUTS

#####################################
### PLACE YOUR OUTPUT VALUES HERE ###
#####################################

output "management_policy_id" {
  description = "The ID of the Storage Account Management Policy."
  value       = azurerm_storage_management_policy.management_policy.id
}