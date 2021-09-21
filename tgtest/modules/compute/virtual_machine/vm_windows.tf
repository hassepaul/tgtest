
resource "azurerm_windows_virtual_machine" "vm" {
  count = try(var.settings.os_type, "") == "windows" ? 1 : 0

  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  name                       = try(var.settings.name, null)
  size                       = try(var.settings.size, null)
  network_interface_ids      = [for name, conf in var.network_interfaces : azurerm_network_interface.nic[name].id]
  admin_username             = try(var.settings.admin_username, null)
  admin_password             = try(var.settings.admin_password, null)
  computer_name              = try(var.settings.computer_name, var.settings.name, null)
  allow_extension_operations = try(var.settings.allow_extension_operations, null)
  eviction_policy            = try(var.settings.eviction_policy, null)
  max_bid_price              = try(var.settings.max_bid_price, null)
  priority                   = try(var.settings.priority, null)
  provision_vm_agent         = try(var.settings.provision_vm_agent, true)
  zone                       = try(var.settings.zone, null)
  enable_automatic_updates   = try(var.settings.enable_automatic_updates, null)
  license_type               = try(var.settings.license_type, null)
  timezone                   = try(var.settings.timezone, null)
  # custom_data                     = try(var.settings.custom_data, null)
  availability_set_id = try(var.availability_set.id, null)

  os_disk {
    name                      = try(var.os_disk.name, null)
    caching                   = try(var.os_disk.caching, null)
    disk_size_gb              = try(var.os_disk.disk_size_gb, null)
    storage_account_type      = try(var.os_disk.storage_account_type, null)
    write_accelerator_enabled = try(var.os_disk.write_accelerator_enabled, null)

    # dynamic "diff_disk_settings" {
    #   for_each = try(each.value.diff_disk_settings, false) == false ? [] : [1]

    #   content {
    #     option = each.value.diff_disk_settings.option
    #   }
    # }
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

  # dynamic "additional_capabilities" {
  #   for_each = try(var.settings.additional_capabilities, false) == false ? [] : [1]

  #   content {
  #     ultra_ssd_enabled = var.settings.additional_capabilities.ultra_ssd_enabled
  #   }
  # }

  # dynamic "additional_unattend_content" {
  #   for_each = try(var.settings.additional_unattend_content, false) == false ? [] : [1]

  #   content {
  #     content = var.settings.additional_unattend_content.content
  #     setting = var.settings.additional_unattend_content.setting
  #   }
  # }

  # dynamic "boot_diagnostics" {
  #   for_each = try(var.boot_diagnostics_storage_account != null ? [1] : var.global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics == true ? [1] : [], [])

  #   content { 
  #     storage_account_uri = var.boot_diagnostics_storage_account == "" ? null : var.boot_diagnostics_storage_account
  #   }
  # }

  # dynamic "secret" {
  #   for_each = try(each.value.winrm.enable_self_signed, false) == false ? [] : [1]

  #   content {

  #     key_vault_id = local.keyvault.id

  #     # WinRM certificate
  #     dynamic "certificate" {
  #       for_each = try(each.value.winrm.enable_self_signed, false) == false ? [] : [1]

  #       content {
  #         url   = azurerm_key_vault_certificate.self_signed_winrm[each.key].secret_id
  #         store = "My"
  #       }
  #     }
  #   }
  # }

  # dynamic "identity" {
  #   for_each = try(each.value.identity, false) == false ? [] : [1]

  #   content {
  #     type         = each.value.identity.type
  #     identity_ids = local.managed_identities
  #   }
  # }

  # dynamic "plan" {
  #   for_each = try(each.value.plan, false) == false ? [] : [1]

  #   content {
  #     name      = each.value.plan.name
  #     product   = each.value.plan.product
  #     publisher = each.value.plan.publisher
  #   }
  # }

  # dynamic "winrm_listener" {
  #   for_each = try(each.value.winrm, false) == false ? [] : [1]

  #   content {
  #     protocol        = try(each.value.winrm.protocol, "Https")
  #     certificate_url = try(each.value.winrm.enable_self_signed, false) ? azurerm_key_vault_certificate.self_signed_winrm[each.key].secret_id : each.value.winrm.certificate_url
  #   }
  # }

}
