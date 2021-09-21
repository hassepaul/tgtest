
# Naming convention
module "naming" {
  source = "../naming"
  suffix = var.suffix
}

# Deploy Storage Account
resource "azurerm_storage_account" "st" {
  name                      = module.naming.storage_account.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  access_tier               = var.access_tier
  enable_https_traffic_only = var.enable_https_traffic_only
  min_tls_version           = var.min_tls_version
  allow_blob_public_access  = var.allow_blob_public_access
  is_hns_enabled            = var.is_hns_enabled

  blob_properties {
    delete_retention_policy {
      days = var.blob_delete_retention_policy_days
    }
  }

  dynamic "custom_domain" {
    for_each = var.custom_domain_name != "" ? [1] : []

    content {
      name          = var.custom_domain_name
      use_subdomain = var.custom_domain_use_subdomain
    }
  }

  dynamic "static_website" {
    for_each = var.static_website_index_document != "" ? [1] : []

    content {
      index_document     = var.static_website_index_document
      error_404_document = var.static_website_error_404_document
    }
  }

  dynamic "network_rules" {
    for_each = var.network_rules == null ? [] : list(var.network_rules)

    content {
      bypass                     = network_rules.value.bypass
      default_action             = network_rules.value.default_action
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
    }
  }

  dynamic "network_rules" {
    for_each = var.network_rules == null ? [1] : []

    content {
      bypass         = ["AzureServices"]
      default_action = "Deny"
    }
  }

  tags = var.tags

}

# Deploy Private Endpoint (optional)
resource "random_id" "private_endpoints" {
  for_each    = local.pe_properties_map
  byte_length = 5
}

resource "azurerm_private_endpoint" "st_pe" {
  for_each = local.pe_properties_map

  name = "pe-${each.value.private_endpoint_subresource}-${azurerm_storage_account.st.name}-${random_id.private_endpoints[each.key].hex}"

  resource_group_name = var.resource_group_name
  location            = var.location

  subnet_id = each.value.subnet_id

  dynamic "private_dns_zone_group" {
    for_each = length(each.value.private_dns_zone_id) != 0 ? [1] : []

    content {
      name                 = module.naming.private_dns_zone_group.name
      private_dns_zone_ids = each.value.private_dns_zone_id
    }

  }

  private_service_connection {
    name                           = "psc-${each.value.private_endpoint_subresource}-${azurerm_storage_account.st.name}-${random_id.private_endpoints[each.key].hex}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.st.id
    subresource_names              = [each.value.private_endpoint_subresource]
  }

  tags = var.tags
}

# Create predefined containers if needed
resource "azurerm_storage_container" "st_cont" {
  for_each             = toset(var.containers)
  name                 = each.key
  storage_account_name = azurerm_storage_account.st.name
}

# Lifecycle management rules
module "lifecycle_management_rules" {
  source = "./management_policy"
  count  = var.management_policy_rules != null ? 1 : 0

  storage_account_id = azurerm_storage_account.st.id
  rules              = var.management_policy_rules

}