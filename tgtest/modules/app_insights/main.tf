
# Naming convention
module "naming" {
  source = "../naming"
  suffix = var.suffix
}

resource "azurerm_application_insights" "ain" {
  name                = module.naming.application_insights.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
  retention_in_days   = var.retention_days
  sampling_percentage = var.sampling_percentage
  disable_ip_masking  = var.disable_ip_masking
  application_type    = var.application_type
}