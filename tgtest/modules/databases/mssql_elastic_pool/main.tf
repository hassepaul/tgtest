
# Naming

module "naming" {
  source = "../../../modules/naming"
  suffix = var.suffix
}

resource "azurerm_mssql_elasticpool" "ep" {
  name                = module.naming.mssql_elasticpool.name
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = var.server_name
  license_type        = var.license_type
  max_size_gb         = var.max_size_gb
  max_size_bytes      = var.max_size_bytes
  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    family   = var.sku_family
    capacity = var.sku_capacity
  }

  per_database_settings {
    min_capacity = var.pds_min_capacity
    max_capacity = var.pds_max_capacity
  }
  tags           = var.tags
  zone_redundant = var.zone_redundant

}
