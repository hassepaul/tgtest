# Sub-module: Recovery Services Vault

Creates a recipient to store backups, snapshots and recovery points.

## Usage

This section explains in more detail the input maps and the expected keys within.

### With Terragrunt

A complete example to create one vm is as follows, from a Terragrunt deployment point-of-view.

Majority of resources are related each other. If these resources are part of the same Terragrunt deployment
we reference them by using their keys.
Else when the resources are defined separately we can resolve those dependencies with Terragrunt by
using "dependency" blocks and then pass the corresponding fiels (normally id's).

```js
inputs = {
  ...

 recovery_vaults = {                                              # this module inputs
   rv1 = {                                                        # key to reference the rsv on the state
     resource_group_key = "rg1"                                   # reference to resource_group key on existing terragrunt

     suffix = ["01"]                                              # naming for this rsv, concatenated with globals prefixes
     sku    = "Standard"                                          # rsv tier

     virtual_machine_policies = {                                 # policies relative to vms
       bv1 = {                                                    # key to identify policy on the state
         name     = "production-nightly"                          # policy name
         timezone = "UTC"                                         # scheduling and retention details
         backup = {
           frequency = "Daily"
           time      = "23:00"
         }
         retention_daily = {
           count = 30
         }
       }
     }

   }
 }
  ...
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.15.0 >= 2.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_policy_vm.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm) | resource |
| [azurerm_recovery_services_vault.rsv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_resource_group.rpc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location of the service | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the namespace | `any` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the Service Bus - Standard or Premium | `any` | n/a | yes |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Specifies the name of the Recovery Vault resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for this resource | `any` | n/a | yes |
| <a name="input_virtual_machine_policies"></a> [virtual\_machine\_policies](#input\_virtual\_machine\_policies) | Backup policies for virtual machines | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Output the object ID |
| <a name="output_name"></a> [name](#output\_name) | Output the Recovery Service vault name |
| <a name="output_virtual_machine_policies"></a> [virtual\_machine\_policies](#output\_virtual\_machine\_policies) | Output the set of backup policies for virtual machines |
