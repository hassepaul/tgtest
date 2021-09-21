
# Recovery services vault
resource "azurerm_recovery_services_vault" "rsv" {
  name                = substr(join("-", ["rsv", join("-", var.suffix)]), 0, 50)
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  tags                = var.tags
  soft_delete_enabled = true

  identity {
    type = "SystemAssigned"
  }
}

# VM backup policies
resource "azurerm_backup_policy_vm" "vm" {
  for_each = try(var.virtual_machine_policies, {})

  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.rsv.name

  name     = each.value.name
  timezone = each.value.timezone
  tags     = var.tags

  dynamic "backup" {
    for_each = try(each.value.backup, null) == null ? [] : [1]

    content {
      frequency = try(each.value.backup.frequency, null)
      time      = try(each.value.backup.time, null)
      weekdays  = try(each.value.backup.weekdays, null)
    }
  }

  dynamic "retention_daily" {
    for_each = try(each.value.retention_daily, null) == null ? [] : [1]

    content {
      count = try(each.value.retention_daily.count, null)
    }
  }

  dynamic "retention_weekly" {
    for_each = try(each.value.retention_weekly, null) == null ? [] : [1]

    content {
      count    = try(each.value.retention_weekly.count, null)
      weekdays = try(each.value.retention_weekly.weekdays, null)
    }
  }

  dynamic "retention_monthly" {
    for_each = try(each.value.retention_monthly, null) == null ? [] : [1]

    content {
      count    = try(each.value.retention_monthly.count, null)
      weekdays = try(each.value.retention_monthly.weekdays, null)
      weeks    = try(each.value.retention_monthly.weeks, null)
    }
  }

  dynamic "retention_yearly" {
    for_each = try(each.value.retention_yearly, null) == null ? [] : [1]

    content {
      count    = try(each.value.retention_yearly.count, null)
      weekdays = try(each.value.retention_yearly.weekdays, null)
      weeks    = try(each.value.retention_yearly.weeks, null)
      months   = try(each.value.retention_yearly.months, null)
    }
  }

}

# Workaround until is integrated on the provider
# https://azure.microsoft.com/en-gb/updates/azurebackuprg/
# https://github.com/terraform-providers/terraform-provider-azurerm/issues/6622
resource "azurerm_resource_group" "rpc" {
  name     = join("_", ["AzureBackupRG", var.location, "1"])
  location = var.location
  tags     = var.tags
}
