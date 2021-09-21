
resource "azurerm_backup_protected_vm" "linux" {
  count = var.settings.os_type == "linux" && try(var.backup.policy_id, null) != null ? 1 : 0

  resource_group_name = var.backup.recovery_vault_rg
  recovery_vault_name = var.backup.recovery_vault_name
  source_vm_id        = azurerm_linux_virtual_machine.vm[0].id
  backup_policy_id    = var.backup.policy_id
}

resource "azurerm_backup_protected_vm" "windows" {
  count = var.settings.os_type == "windows" && try(var.backup.policy_id, null) != null ? 1 : 0

  resource_group_name = var.backup.recovery_vault_rg
  recovery_vault_name = var.backup.recovery_vault_name
  source_vm_id        = azurerm_windows_virtual_machine.vm[0].id
  backup_policy_id    = var.backup.policy_id
}
