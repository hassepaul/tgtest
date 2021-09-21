
output "id" {
  description = "The resource ID"
  value       = azurerm_redis_cache.db.id
}

output "hostname" {
  description = "The hostname of the Redis instance"
  value       = azurerm_redis_cache.db.hostname
}

output "primary_access_key" {
  description = "The Primary Access Key for the Redis Instance"
  value       = azurerm_redis_cache.db.primary_access_key
}

output "primary_connection_string" {
  description = "The primary connection string of the Redis Instance."
  value       = azurerm_redis_cache.db.primary_connection_string
}
