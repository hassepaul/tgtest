#######################################
### PLACE YOUR DEPLOYMENT CODE HERE ###
#######################################

resource "azurerm_storage_management_policy" "management_policy" {
  storage_account_id = var.storage_account_id

  dynamic "rule" {
    for_each = var.rules

    content {
      name    = rule.value["name"]
      enabled = rule.value["enabled"]

      filters {
        prefix_match = try(rule.value.filters.prefix_match, [])
        blob_types   = try(rule.value.filters.blob_types, ["blockBlob"])
      }

      dynamic "actions" {
        for_each = lookup(rule.value, "actions", false) == false ? [] : [1]

        content {
          dynamic "base_blob" {
            for_each = lookup(rule.value.actions, "base_blob", false) == false ? [] : [1]

            content {
              tier_to_cool_after_days_since_modification_greater_than    = lookup(rule.value.actions.base_blob, "tier_to_cool", 0)
              tier_to_archive_after_days_since_modification_greater_than = lookup(rule.value.actions.base_blob, "tier_to_archive", 0)
              delete_after_days_since_modification_greater_than          = lookup(rule.value.actions.base_blob, "delete_after_days", 0)
            }
          }

          dynamic "snapshot" {
            for_each = lookup(rule.value.actions, "snapshot", false) == false ? [] : [1]

            content {
              delete_after_days_since_creation_greater_than = lookup(rule.value.actions.snapshot, "delete_after_days", 0)
            }
          }
        }
      }
    }
  }
}
