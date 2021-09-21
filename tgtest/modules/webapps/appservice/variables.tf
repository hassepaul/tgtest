
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

variable "app_service_plan_id" {
  description = "ID for the Service Plan that will contain this App Service"
}

variable "client_affinity_enabled" {}
variable "client_cert_enabled" {}
variable "enabled" {}
variable "https_only" {}
variable "app_insight_instrumentation_key" {}

variable "backup" {}
variable "app_settings" {}
variable "site_config" {}
variable "private_inbound" {}
variable "subnet_id" {}
variable "custom_dns" {}
