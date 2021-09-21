
data "azuread_user" "mssql_admin" {
  count = try(var.administrator.user, null) != null ? 1 : 0
  user_principal_name = var.administrator.user
}