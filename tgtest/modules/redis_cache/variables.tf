
variable "suffix" {
  description = "Resource naming definition"
}

variable "resource_group_name" {
  description = "The resource group name in which to put the virtual machine"
}

variable "location" {
  description = "The location where to create the resource"
}

variable "tags" {
  description = "Tags for this resource"
}

variable "family" {
  description = "The SKU pricing group to use. Valid values are C (basic/std) and P (premium)"
}

variable "sku" {
  description = "The SKU of Redis to use. Possible values are Basic, Standard and Premium"
}

variable "capacity" {
  description = "The size of the Redis cache to deploy."
}

variable "subnet_id" {
  description = "The ID of the Subnet to integrate Redis Cache with."
}

variable "shard_count" {
  description = "The number of Shards to create on the Redis Cluster."
}

variable "enable_non_ssl_port" {
  description = "Enable the non-SSL port (6379) - disabled by default."
}

variable "minimum_tls_version" {
  description = "The minimum TLS version"
}

variable "redis_configuration" {
  description = "Additional configuration for the Redis instance."
}

variable "blob_string" {
  description = "Storage Account Blob connection string for backups - used when 'rdb_storage_connection_string' is not provided on 'redis_configuration'"
}

variable "diagnostics_enabled" {
  description = "enables all monitoring diagnostics for the current resource"
}

variable "diagnostics_map" {
  description = "Contains the SA and EH details for operations diagnostics"
}

variable "log_analytics_workspace" {
  description = "Contains the log analytics workspace details for operations diagnostics"
}

variable "diagnostics_settings" {
  description = "Configuration object describing the diagnostics"
}
