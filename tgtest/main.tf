/**
 * # Modules wrapper documentation
 * 
 * This portion bootstraps all the code execution and gets triggered from the landing zones definition
 *
 * ## Usage
 * 
 * * Include this root path on your landing zone as a module
 * * Landing zone interface implementation is a sub-set of the wrapper's interface
 * 
*/

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.71.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

  # subscription_id = "..."
  # client_id       = "..."
  # client_secret   = "..."
  # tenant_id       = "..."
}
 
