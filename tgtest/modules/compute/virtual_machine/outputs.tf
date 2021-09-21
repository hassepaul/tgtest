
output "id" {
  description = "Virtual Machine ID"
  value       = try(azurerm_linux_virtual_machine.vm[0].id, azurerm_windows_virtual_machine.vm[0].id, null)
}

output "hostname" {
  description = "Virtual Machine hostname"
  value       = try(azurerm_linux_virtual_machine.vm[0].computer_name, azurerm_windows_virtual_machine.vm[0].computer_name, null)
}

output "primary_ip" {
  description = "Virtual Machine primary private IP"
  value       = try(azurerm_linux_virtual_machine.vm[0].private_ip_address, azurerm_windows_virtual_machine.vm[0].private_ip_address, null)
}
