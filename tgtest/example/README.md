# HRX Landing zone documentation

This solution definition is meant to be as generic as possible, allowing any component to plug-in if the
corresponding data is provded.

Landing zones only define their variables environment based on the "module wrapper" features claimed.
It will then call the "root module" to bootstrap the process.
Paths for landingzones from Terragrunt are important and have a couple of details to take into account:
  - Use the double-slash just before landing zone name, so that all the surrounding code is downloaded properly
  - Meant to be called in isolation as part of a particular Terragrunt deployment
  - Acts as an abstraction layer to deliver a technology or stack component; it's aligned with business solution

## Usage

This section explains in more detail the input maps and the expected keys within.

to-do

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 0.11.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.31.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 2.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_hrx"></a> [hrx](#module\_hrx) | ../ |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_clusters"></a> [aks\_clusters](#input\_aks\_clusters) | n/a | `any` | `{}` | no |
| <a name="input_appinsights"></a> [appinsights](#input\_appinsights) | n/a | `any` | `{}` | no |
| <a name="input_appservice_plans"></a> [appservice\_plans](#input\_appservice\_plans) | n/a | `any` | `{}` | no |
| <a name="input_functionapps"></a> [functionapps](#input\_functionapps) | n/a | `any` | `{}` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | n/a | `any` | `{}` | no |
| <a name="input_keyvaults"></a> [keyvaults](#input\_keyvaults) | n/a | `any` | `{}` | no |
| <a name="input_mssql_databases"></a> [mssql\_databases](#input\_mssql\_databases) | n/a | `any` | `{}` | no |
| <a name="input_mssql_pools"></a> [mssql\_pools](#input\_mssql\_pools) | n/a | `any` | `{}` | no |
| <a name="input_mssql_servers"></a> [mssql\_servers](#input\_mssql\_servers) | n/a | `any` | `{}` | no |
| <a name="input_recovery_vaults"></a> [recovery\_vaults](#input\_recovery\_vaults) | n/a | `any` | `{}` | no |
| <a name="input_redis_clusters"></a> [redis\_clusters](#input\_redis\_clusters) | n/a | `any` | `{}` | no |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | n/a | `any` | `{}` | no |
| <a name="input_service_bus"></a> [service\_bus](#input\_service\_bus) | n/a | `any` | `{}` | no |
| <a name="input_storage_accounts"></a> [storage\_accounts](#input\_storage\_accounts) | n/a | `any` | `{}` | no |
| <a name="input_virtual_machines"></a> [virtual\_machines](#input\_virtual\_machines) | n/a | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hrx"></a> [hrx](#output\_hrx) | n/a |
