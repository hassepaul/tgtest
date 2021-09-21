
module "naming" {
  source = "../../naming"
  suffix = var.suffix
}

resource "azurerm_data_factory" "df" {
  name                = module.naming.data_factory.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  public_network_enabled  = try(var.settings.public_network_enabled, false)
  dynamic "github_configuration" {
    for_each = try(var.github_configuration, {}) != {} ? [var.github_configuration] : []

    content {
      account_name    = github_configuration.value.account_name
      branch_name     = github_configuration.value.branch_name
      git_url         = github_configuration.value.git_url
      repository_name = github_configuration.value.repository_name
      root_folder     = github_configuration.value.root_folder
    }
  }

  dynamic "identity" {
    for_each = try(var.identity, {}) != {} ? [var.identity] : []

    content {
      type = identity.value.type
    }
  }

  dynamic "vsts_configuration" {
    for_each = try(var.vsts_configuration, {}) != {} ? [var.vsts_configuration] : []

    content {
      account_name    = vsts_configuration.value.account_name
      branch_name     = vsts_configuration.value.branch_name
      project_name    = vsts_configuration.value.project_name
      repository_name = vsts_configuration.value.repository_name
      root_folder     = vsts_configuration.value.root_folder
      tenant_id       = vsts_configuration.value.tenant_id
    }
  }

}
