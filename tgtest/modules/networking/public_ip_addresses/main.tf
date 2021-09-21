# Naming convention
module "naming" {
  source = "git::ssh://ProdNGAHR@vs-ssh.visualstudio.com/v3/ProdNGAHR/GT%20Cloud/terraform-azurerm-naming?ref=solution"
  suffix = var.name
}

resource "azurerm_public_ip" "pip" {
  name                    = module.naming.public_ip.name
  resource_group_name     = var.resource_group_name
  location                = var.location
  allocation_method       = var.allocation_method
  sku                     = var.sku
  ip_version              = var.ip_version
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  domain_name_label       = var.generate_domain_name_label ? module.naming.public_ip.name : var.domain_name_label
  reverse_fqdn            = var.reverse_fqdn
  zones                   = var.zones
  tags                    = var.tags
}