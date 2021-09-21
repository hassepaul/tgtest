
# Naming convention
module "naming" {
  source = "../naming"
  suffix = var.suffix
}

# Resource group creation
resource "azurerm_resource_group" "main" {
  name     = module.naming.resource_group.name
  location = var.location
  tags     = var.tags
}