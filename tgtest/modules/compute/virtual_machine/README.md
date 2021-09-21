# Sub-module: Virtual Machine

Setup a virtual machine, either Linux or Windows, including local disks, network interfaces and
backup configuration.

## Usage

This section explains in more detail the input maps and the expected keys within.

### With Terragrunt

A complete example to create one vm is as follows, from a Terragrunt deployment point-of-view.
Majority of resources are related each other.

If these resources are part of the same Terragrunt deployment we reference them by using their keys.
Else when the resources are defined separately we can resolve those dependencies with Terragrunt by
using "dependency" blocks and then pass the corresponding fiels (normally id's).

```js
inputs = {
  ...

  virtual_machines = {                                            # this module inputs
    vm1 = {                                                       # key to reference vm on the state
      resource_group_key = "rg1"                                  # reference to resource_group key, created
                                                                  #   on existing terragrunt file

      settings = {                                                # settings map, containing main vm features
        os_type        = "linux"                                  # (required) linux or windows?
        name           = "hosazr01lab01"                          # (required) name visible on the portal
        computer_name  = "hosazr01lab01"                          # (required) name configured inside the vm
        size           = "Standard_B1ms"                          # (required) vm size
        admin_username = "cloudadmin"                             # user and password
        admin_password = "NGA;1234"
      }
      os_disk = {                                                 # os_disk map, contains the installation disk details
        name                 = "dsk-01-hosazr01lab01"             # (required) disk name
        storage_account_type = "Standard_LRS"                     # (required) disk type, i.e std vs premium?
        caching              = "ReadWrite"
      }
      source_image_reference = {                                  # when using a system image from Azure,
        publisher = "Canonical"                                   # provide all the details on vendor, version etc
        offer     = "0001-com-ubuntu-minimal-focal-daily"
        sku       = "minimal-20_04-daily-lts-gen2"
        version   = "latest"
      }
      network_interfaces = {                                      # nics details
        nic1 = {
          name      = "nic-01-hosazr01lab01"                      # (required) nic name
          subnet_id = dependency.spoke.outputs.subnets.vm-sub     # (required) subnet where to create this nic on,
        }                                                         # depends on network spoke which is normally
      }                                                           # defined separately

      backup = {                                                  # backup configuration
        resource_group_key = "rg1"                                # key to reference the rg where the rsv is placed
        recovery_vault_key = "rv1"                                # key to reference the rsv object
        policy_key         = "bv1"                                # the backup policy within rsv we want to set
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
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.15.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.15.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_protected_vm.linux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm) | resource |
| [azurerm_backup_protected_vm.windows](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm) | resource |
| [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_data_disk_attachment.disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_windows_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_ssh_key"></a> [admin\_ssh\_key](#input\_admin\_ssh\_key) | Block to use SSH logging | `any` | n/a | yes |
| <a name="input_availability_set"></a> [availability\_set](#input\_availability\_set) | Configuration block containing availability set details | `any` | n/a | yes |
| <a name="input_backup"></a> [backup](#input\_backup) | Configuration block containing info about recovery vault and backup policy | `any` | n/a | yes |
| <a name="input_disks"></a> [disks](#input\_disks) | Disks to attach to this virtual  machine. | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. | `any` | n/a | yes |
| <a name="input_network_interfaces"></a> [network\_interfaces](#input\_network\_interfaces) | Networking interfaces to attach to this virtual machine | `any` | n/a | yes |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | Details to create the disk containing the OS install | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name in which to put the virtual machine | `any` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Virtual Machine configuration details | `any` | n/a | yes |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | Details to deploy from a system image | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for this resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | Virtual Machine hostname |
| <a name="output_id"></a> [id](#output\_id) | Virtual Machine ID |
| <a name="output_primary_ip"></a> [primary\_ip](#output\_primary\_ip) | Virtual Machine primary private IP |
