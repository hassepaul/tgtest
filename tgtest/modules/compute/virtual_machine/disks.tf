
resource "azurerm_managed_disk" "disk" {
  for_each = try(var.disks, {})

  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  name                 = try(each.value.name, null)
  storage_account_type = try(each.value.storage_account_type, null)
  create_option        = try(each.value.create_option, "Empty")
  disk_size_gb         = try(each.value.disk_size_gb, null)
  zones                = try(each.value.zones, null)
  disk_iops_read_write = try(each.value.disk_iops_read_write, null)
  disk_mbps_read_write = try(each.value.disk.disk_mbps_read_write, null)
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk" {
  for_each = try(var.disks, {})

  managed_disk_id           = azurerm_managed_disk.disk[each.key].id
  virtual_machine_id        = var.settings.os_type == "linux" ? azurerm_linux_virtual_machine.vm.0.id : azurerm_windows_virtual_machine.vm.0.id
  lun                       = each.value.lun
  caching                   = try(each.value.caching, "None")
  write_accelerator_enabled = try(each.value.write_accelerator_enabled, false)
}
