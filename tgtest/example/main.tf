/**
 * # Landing zone documentation
 * 
 * This solution definition is meant to be as generic as possible, allowing any component to plug-in if the
 * corresponding data is provded.
 *
 * Landing zones only define their variables environment based on the "module wrapper" features claimed.
 * It will then call the "root module" to bootstrap the process.
 * Paths for landingzones from Terragrunt are important and have a couple of details to take into account:
 *   - Use the double-slash just before landing zone name, so that all the surrounding code is downloaded properly
 *   - Meant to be called in isolation as part of a particular Terragrunt deployment
 *   - Acts as an abstraction layer to deliver a technology or stack component; it's aligned with business solution
 *
 * ## Usage
 * 
 * This section explains in more detail the input maps and the expected keys within.
 *
 * to-do
 * 
 */

terraform {
  required_version = ">= 0.13.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.31.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.5.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2"
    }
  }

}
