/**
 * # Module: Virtual Machine
 * 
 * Setup a virtual machine, either Linux or Windows, including local disks, network interfaces and
 * backup configuration.
 *
 * ## Usage
 * 
 * This section explains in more detail the input maps and the expected keys within.
 *
 * ### With Terragrunt
 * 
 * A complete example to create one vm is as follows, from a Terragrunt deployment point-of-view.
 * Majority of resources are related each other. 
 * 
 * If these resources are part of the same Terragrunt deployment we reference them by using their keys. 
 * Else when the resources are defined separately we can resolve those dependencies with Terragrunt by 
 * using "dependency" blocks and then pass the corresponding fiels (normally id's).
 *
 * ```js
 * inputs = {
 *   ...
 *   
 *   virtual_machines = {                                            # this module inputs
 *     vm1 = {                                                       # key to reference vm on the state
 *       resource_group_key = "rg1"                                  # reference to resource_group key, created
 *                                                                   #   on existing terragrunt file
 *
 *       settings = {                                                # settings map, containing main vm features
 *         os_type        = "linux"                                  # (required) linux or windows?
 *         name           = "hosazr01lab01"                          # (required) name visible on the portal
 *         computer_name  = "hosazr01lab01"                          # (required) name configured inside the vm
 *         size           = "Standard_B1ms"                          # (required) vm size
 *         admin_username = "cloudadmin"                             # user and password
 *         admin_password = "NGA;1234"
 *       }
 *       os_disk = {                                                 # os_disk map, contains the installation disk details
 *         name                 = "dsk-01-hosazr01lab01"             # (required) disk name
 *         storage_account_type = "Standard_LRS"                     # (required) disk type, i.e std vs premium?
 *         caching              = "ReadWrite"
 *       }
 *       source_image_reference = {                                  # when using a system image from Azure,
 *         publisher = "Canonical"                                   # provide all the details on vendor, version etc
 *         offer     = "0001-com-ubuntu-minimal-focal-daily"
 *         sku       = "minimal-20_04-daily-lts-gen2"
 *         version   = "latest"
 *       }
 *       network_interfaces = {                                      # nics details
 *         nic1 = {
 *           name      = "nic-01-hosazr01lab01"                      # (required) nic name
 *           subnet_id = dependency.spoke.outputs.subnets.vm-sub     # (required) subnet where to create this nic on,
 *         }                                                         # depends on network spoke which is normally
 *       }                                                           # defined separately
 *       
 *       backup = {                                                  # backup configuration
 *         resource_group_key = "rg1"                                # key to reference the rg where the rsv is placed
 *         recovery_vault_key = "rv1"                                # key to reference the rsv object
 *         policy_key         = "bv1"                                # the backup policy within rsv we want to set
 *       }
 *     }
 *   }
 *
 *   ...
 * }
 * ```
 */

terraform {
  required_version = ">= 0.13.0"
  required_providers {
    azurerm = ">= 2.15.0"
  }
}
