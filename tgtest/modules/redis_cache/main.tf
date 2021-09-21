

# Terraform specific settings

terraform {
  required_version = ">= 0.12.26"
  required_providers {
    azurerm = ">= 2.15.0"
  }
}

module "naming" {
  source = "../naming"
  suffix = var.suffix
}

module "diagnostics" {
  source                  = "git::ssh://ProdNGAHR@vs-ssh.visualstudio.com/v3/ProdNGAHR/GT%20Cloud/tf-azurerm-mod-diagnostics-monitoring?ref=1.0.2"
  resource_name           = module.naming.redis_cache.name
  diagnostics_map         = var.diagnostics_map
  log_analytics_workspace = var.log_analytics_workspace
  diagnostics_settings    = var.diagnostics_settings
  diagnostics_enabled     = var.diagnostics_enabled
  target_resource_id      = azurerm_redis_cache.db.id
}

# deploy redis cache

resource "azurerm_redis_cache" "db" {
  name                = module.naming.redis_cache.name
  resource_group_name = var.resource_group_name
  location            = var.location
  family              = var.family
  sku_name            = var.sku
  subnet_id           = var.subnet_id
  shard_count         = var.shard_count
  capacity            = var.capacity
  enable_non_ssl_port = var.enable_non_ssl_port
  minimum_tls_version = var.minimum_tls_version
  tags                = var.tags

  dynamic "redis_configuration" {
    for_each = try(var.redis_configuration, {}) != {} ? [var.redis_configuration] : []

    content {
      enable_authentication           = lookup(var.redis_configuration, "enable_authentication", null)
      maxfragmentationmemory_reserved = lookup(var.redis_configuration, "maxfragmentationmemory_reserved", null)
      maxmemory_delta                 = lookup(var.redis_configuration, "maxmemory_delta", null)
      maxmemory_policy                = lookup(var.redis_configuration, "maxmemory_policy", null)
      maxmemory_reserved              = lookup(var.redis_configuration, "maxmemory_reserved", null)
      notify_keyspace_events          = lookup(var.redis_configuration, "notify_keyspace_events", null)
      rdb_backup_enabled              = lookup(var.redis_configuration, "rdb_backup_enabled", null)
      rdb_backup_frequency            = lookup(var.redis_configuration, "rdb_backup_frequency", null)
      rdb_backup_max_snapshot_count   = lookup(var.redis_configuration, "rdb_backup_max_snapshot_count", null)
      rdb_storage_connection_string   = try(var.blob_string, null)
    }
  }

}
