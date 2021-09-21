
output "id" {
  description = "Output the object ID"
  value       = azurerm_recovery_services_vault.rsv.id
}

output "name" {
  description = "Output the Recovery Service vault name"
  value       = azurerm_recovery_services_vault.rsv.name
}

output "virtual_machine_policies" {
  description = "Output the set of backup policies for virtual machines"
  value       = azurerm_backup_policy_vm.vm
}
