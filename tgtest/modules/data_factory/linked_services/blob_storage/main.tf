
/**
 * # Module: Data Factory
 *
 * Setup a data factory linked service resource for blob storage.
 *
 * ## Usage
 *
 * This section explains in more detail the input maps and the expected keys within.
 *
 * ### With Terragrunt
 *
 * TODO
 *
 * ```js
 * inputs = {
 *   ...
 *
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

module "naming" {
  source = "../../../naming"
  suffix = var.suffix
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "adfsvst" {
  name                = module.naming.data_factory_linked_service_blob_storage.name
  resource_group_name = var.resource_group_name
  data_factory_name   = var.data_factory_name
  connection_string   = var.connection_string
}
