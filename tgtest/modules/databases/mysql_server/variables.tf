
variable "resource_group_name" {
  description = "The resource group in which to put the MySQL server."
}

variable "location" {
  description = "Region to deploy resources within"
}

variable "tags" {
  description = "Tags to apply to all resources created."
}

variable "suffix" {
  description = "A naming suffix to be used in the creation of unique names for Azure resources."
}

variable "mysql_config" {
  description = "Additional MySQL parameters"
}

variable "server_config" {
  description = "Instance settings"
}

variable "subnet_id" {
  description = "The subnet id of the private endpoint."
}

variable "private_dns_zone_ids" {
  description = "The private dns zones to use with the private endpoint."
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

variable "diagnostics_enabled" {
  description = "Enables all monitoring diagnostics for the current resource"
}
