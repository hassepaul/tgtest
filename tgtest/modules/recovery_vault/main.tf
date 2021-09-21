/**
  * # Module: Recovery Services Vault
  * 
  * Creates a recipient to store backups, snapshots and recovery points.
  *
  * ## Usage
  * 
  * This section explains in more detail the input maps and the expected keys within.
  *
  * ### With Terragrunt
  *
  * A complete example to create one vm is as follows, from a Terragrunt deployment point-of-view.
  *
  * Majority of resources are related each other. If these resources are part of the same Terragrunt deployment
  * we reference them by using their keys. 
  * Else when the resources are defined separately we can resolve those dependencies with Terragrunt by 
  * using "dependency" blocks and then pass the corresponding fiels (normally id's).
  *
  * ```js
  * inputs = {
  *   ...
  *  
  *  recovery_vaults = {                                              # this module inputs
  *    rv1 = {                                                        # key to reference the rsv on the state
  *      resource_group_key = "rg1"                                   # reference to resource_group key on existing terragrunt
  *
  *      suffix = ["01"]                                              # naming for this rsv, concatenated with globals prefixes
  *      sku    = "Standard"                                          # rsv tier
  *    
  *      virtual_machine_policies = {                                 # policies relative to vms
  *        bv1 = {                                                    # key to identify policy on the state
  *          name     = "production-nightly"                          # policy name
  *          timezone = "UTC"                                         # scheduling and retention details
  *          backup = {
  *            frequency = "Daily"
  *            time      = "23:00"
  *          }
  *          retention_daily = {
  *            count = 30
  *          }
  *        }
  *      }
  *    
  *    }
  *  }
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
