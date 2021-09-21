variable suffix {
  type        = list(string)
  description = "Naming for primary resources"
}

variable "resource_group_name" {
  type        = string
  description = "SQL server resource group"
}

variable location {
  type        = string
  description = "SQL server location"
}

variable server_version {
  type        = string
  description = "SQL server version"
  default     = "12.0"
}

variable admin_user {
  type        = string
  description = "SQL admin user"
  default     = "mssqladmin"
}

variable password {
  type        = string
  description = "SQL admin password"
}

variable tags {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "The subnet id of the private endpoint."
  type        = string
  default     = null
}

variable "sa_primary_blob_endpoint" {
  description = "Storage account endpoint"
  type        = string
}

variable "sa_id" {
  description = "Storage account id"
  type        = string
}

# Note: the private dns zone name needs to be privatelink.database.windows.net.
# https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-dns
variable "private_dns_zone_ids" {
  description = "The private dns zones to use with the private endpoint."
  type        = list(string)
  default     = []
}

# Note: the private dns zone name needs to be privatelink.database.windows.net.
# https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-dns
variable "private_dns_zone_ids_secondary" {
  description = "The private dns zones to use with the private endpoint."
  type        = list(string)
  default     = []
}

variable "minimum_tls" {
  default     = "1.2"
  type        = string
  description = "(Optional) The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server. Valid values are: 1.0, 1.1 and 1.2.n"
}

variable "public_network_access_enabled" {
  default     = false
  type        = bool
  description = "(Optional) Whether or not public network access is allowed for this server. Defaults to true."
}

variable "retention_days" {
  default     = 90
  type        = number
  description = "(Optional) Retention days of the audit"
}

variable "administrator" {
  default     = null
  type        = map
  description = "Map containing the login username of the Azure AD Administrator of this SQL Server and the email address of that user."
}

#variable "sa_replication_type"{
#  type = string
#  default = "LRS"
#  description = "SA Replication type - defaults to LRS"
#}

#variable "sa_name" {
#  description = "SA Name"
#}
