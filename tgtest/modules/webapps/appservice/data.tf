
data "azurerm_storage_account" "backup_storage_account" {
  count = try(var.backup, {}) != {} ? 1 : 0

  name                = var.backup.storage_account_name
  resource_group_name = var.backup.storage_account_resource_group_name
}

data "azurerm_storage_account_blob_container_sas" "backup" {
  count = try(var.backup, {}) != {} ? 1 : 0

  connection_string = data.azurerm_storage_account.backup_storage_account.0.primary_connection_string
  container_name    = var.backup.container_name
  https_only        = true

  start             = "2020-01-03T17:18:00Z"
  expiry            = "2030-12-31T23:59:59Z"

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }
}
