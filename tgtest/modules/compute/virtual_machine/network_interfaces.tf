
resource "azurerm_network_interface" "nic" {
  for_each = try(var.network_interfaces, {})

  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  name                          = each.value.name
  dns_servers                   = try(each.value.dns_servers, null)
  enable_ip_forwarding          = try(each.value.enable_ip_forwarding, false)
  enable_accelerated_networking = try(each.value.enable_accelerated_networking, false)
  internal_dns_name_label       = try(each.value.internal_dns_name_label, null)

  ip_configuration {
    name                          = try(each.value.name, "primary")
    subnet_id                     = try(each.value.subnet_id, null)
    private_ip_address_allocation = try(each.value.private_ip_address_allocation, "Dynamic")
    private_ip_address_version    = try(each.value.private_ip_address_version, null)
    private_ip_address            = try(each.value.private_ip_address, null)
    primary                       = try(each.value.primary, null)
    public_ip_address_id          = try(each.value.public_ip_address_id, null)
  }

  dynamic "ip_configuration" {
    for_each = try(each.value.ip_configurations, {})

    content {
      name                          = try(ip_configuration.value.name, "secondary")
      subnet_id                     = try(ip_configuration.value.subnet_id, each.value.subnet_id, null)
      private_ip_address_allocation = try(ip_configuration.value.private_ip_address_allocation, "Dynamic")
      private_ip_address_version    = try(ip_configuration.value.private_ip_address_version, null)
      private_ip_address            = try(ip_configuration.value.private_ip_address, null)
      primary                       = try(ip_configuration.value.primary, null)
      public_ip_address_id          = try(ip_configuration.value.public_ip_address_id, each.value.public_ip_address_id, null)
    }
  }
}
