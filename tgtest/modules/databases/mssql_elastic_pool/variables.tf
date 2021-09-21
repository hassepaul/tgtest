variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the elastic pool. This must be the same as the resource group of the underlying SQL server."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable suffix {
  type        = list(string)
  description = "(Required) The name of the elastic pool. This needs to be globally unique. Changing this forces a new resource to be created."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "server_name" {
  description = " (Required) The name of the SQL Server on which to create the elastic pool. Changing this forces a new resource to be created."
  default     = {}
}

variable "license_type" {
  description = "(Optional) Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice."
  default     = "BasePrice"
}

variable "max_size_gb" {
  description = "(Optional) The max data size of the elastic pool in gigabytes. Conflicts with max_size_bytes."
  default     = {}
}
variable "max_size_bytes" {
  description = "(Optional) The max data size of the elastic pool in bytes. Conflicts with max_size_gb."
  default     = {}
}

variable "sku_name" {
  description = ""
  default     = "BasicPool"
}
variable "sku_tier" {
  description = ""
  default     = "Basic"
}
variable "sku_family" {
  description = ""
  default     = "Gen5"
}
variable "sku_capacity" {
  description = ""
  default     = {}
}
variable "pds_min_capacity" {
  description = ""
  default     = {}
}
variable "pds_max_capacity" {
  description = ""
  default     = {}
}
variable "zone_redundant" {
  description = "(Optional) Whether or not this elastic pool is zone redundant. tier needs to be Premium for DTU based or BusinessCritical for vCore based sku. Defaults to false."
  default     = "false"
}
