/**
 * # Module: Data Factory
 *
 * Setup a data factory resource.
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
 *   data_factory = {                                                # this module inputs
 *     df1 = {                                                       # key to reference vm on the state
 *       resource_group_key = "rg1"                                  # reference to resource_group key, created
 *                                                                   #   on existing terragrunt file
 *
 *       github_configuration = {                                    # github config block
 *         ...
 *       }
 *       identity = {                                                # identity block
 *         ...
 *       }
 *       vsts_configuration = {                                      # vsts configuration block
 *         ...
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
