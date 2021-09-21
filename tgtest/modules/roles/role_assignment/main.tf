
resource "azurerm_role_assignment" "main" {
  for_each = try(var.resources, {})

  scope                = var.scope
  role_definition_name = var.role_definition_name
  principal_id         = each.value
}

resource "azurerm_role_assignment" "ad_users" {
  for_each = try(var.ad_users, {})

  scope                = var.scope
  role_definition_name = var.role_definition_name
  principal_id         = data.azuread_user.ad_users[each.key].id
}

resource "azurerm_role_assignment" "ad_groups" {
  for_each = try(var.ad_groups, {})

  scope                = var.scope
  role_definition_name = var.role_definition_name
  principal_id         = data.azuread_group.ad_groups[each.key].id
}

resource "azurerm_role_assignment" "ad_apps" {
  for_each = try(var.ad_apps, {})

  scope                = var.scope
  role_definition_name = var.role_definition_name
  principal_id         = data.azuread_service_principal.ad_apps[each.key].object_id
}