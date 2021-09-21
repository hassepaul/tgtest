
data "azuread_user" "ad_users" {
  for_each            = var.ad_users
  user_principal_name = each.value
}

data "azuread_group" "ad_groups" {
  for_each     = var.ad_groups
  display_name = each.value
}

data "azuread_service_principal" "ad_apps" {
  for_each     = var.ad_apps
  display_name = each.value
}