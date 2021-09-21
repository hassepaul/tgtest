
resource "azurerm_linux_virtual_machine" "vm" {
  count = try(var.settings.os_type, "") == "linux" ? 1 : 0

  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  name                            = try(var.settings.name, null)
  size                            = try(var.settings.size, null)
  network_interface_ids           = [for name, conf in var.network_interfaces : azurerm_network_interface.nic[name].id]
  admin_username                  = try(var.settings.admin_username, null)
  admin_password                  = try(var.settings.admin_password, null)
  computer_name                   = try(var.settings.computer_name, var.settings.name, null)
  allow_extension_operations      = try(var.settings.allow_extension_operations, null)
  eviction_policy                 = try(var.settings.eviction_policy, null)
  max_bid_price                   = try(var.settings.max_bid_price, null)
  priority                        = try(var.settings.priority, null)
  provision_vm_agent              = try(var.settings.provision_vm_agent, null)
  zone                            = try(var.settings.zone, null)
  disable_password_authentication = try(var.settings.disable_password_authentication, false)
  # custom_data                     = try(var.settings.custom_data, null)
  availability_set_id = try(var.availability_set.id, null)

  os_disk {
    name                      = try(var.os_disk.name, null)
    caching                   = try(var.os_disk.caching, null)
    disk_size_gb              = try(var.os_disk.disk_size_gb, null)
    storage_account_type      = try(var.os_disk.storage_account_type, null)
    write_accelerator_enabled = try(var.os_disk.write_accelerator_enabled, null)
  }

  # One of either "source_image_id" or "source_image_reference" must be set.
  source_image_id = try(var.source_image_reference, {}) == {} ? try(var.settings.source_image_id, null) : null

  dynamic "source_image_reference" {
    for_each = try(var.source_image_reference, {}) != {} ? [1] : []

    content {
      publisher = try(var.source_image_reference.publisher, null)
      offer     = try(var.source_image_reference.offer, null)
      sku       = try(var.source_image_reference.sku, null)
      version   = try(var.source_image_reference.version, null)
    }
  }

  # dynamic "admin_ssh_key" {
  #   for_each = try(each.value.disable_password_authentication, true) ? [1] : []

  #   content {
  #     username   = each.value.admin_username
  #     public_key = local.create_sshkeys ? tls_private_key.ssh[each.key].public_key_openssh : file(var.settings.public_key_pem_file)
  #   }
  # }

  # dynamic "identity" {
  #   for_each = try(each.value.identity, false) == false ? [] : [1]

  #   content {
  #     type         = each.value.identity.type
  #     identity_ids = local.managed_identities
  #   }
  # }

  # dynamic "boot_diagnostics" {
  #   for_each = var.boot_diagnostics_storage_account == {} ? [] : [1]

  #   content {
  #     storage_account_uri = var.boot_diagnostics_storage_account
  #   }
  # }

}
