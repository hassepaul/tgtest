
data "azurerm_client_config" "current" {}

data "azuread_user" "ad_users" {
  for_each            = local.user_access_policies_map
  user_principal_name = each.key
}

data "azuread_group" "ad_groups" {
  for_each     = local.group_access_policies_map
  display_name = each.key
}

data "azuread_service_principal" "ad_apps" {
  for_each     = local.app_access_policies_map
  display_name = each.key
}



