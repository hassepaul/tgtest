
variable "resource_group_name" {
  description = "The resource group in which to put the resource"
  type        = string
}

variable "location" {
  description = "The location where to create the resource"
  type        = string
}

variable "tags" {
  description = "Tags for this resource"
  type        = map(string)
}

variable "suffix" {
  description = "Resource naming definition"
  type        = list(string)
}

variable "account_kind" {
  description = "Storage kind - valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2 "
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium"
  type        = string
}

variable "account_replication_type" {
  description = "Storage replication type - valid options are LRS, GRS, RAGRS and ZRS "
  type        = string
}

variable "access_tier" {
  description = "Storage replication access tier - valid options are Hot and Cool"
  type        = string
}

variable "enable_https_traffic_only" {
  description = "Boolean flag which forces HTTPS if enabled"
  type        = bool
}

variable "min_tls_version" {
  description = "Set the minimum supported TLS version for the storage account"
  type        = string
}

variable "allow_blob_public_access" {
  description = "Allow or disallow public access to all blobs or containers in the storage account"
  type        = bool
}

variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2"
  type        = bool
}

variable "blob_delete_retention_policy_days" {
  description = "Specifies the number of days that the blob should be retained, between 1 and 365 days"
  type        = number
}

variable "custom_domain_name" {
  description = "The Custom Domain Name to use for the Storage Account, which will be validated by Azure"
  type        = string
}

variable "custom_domain_use_subdomain" {
  description = "Should the Custom Domain Name be validated by using indirect CNAME validation?"
  type        = bool
}

variable "static_website_index_document" {
  description = "The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive"
  type        = string
}

variable "static_website_error_404_document" {
  description = "The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file"
  type        = string
}

variable "network_rules" {
  description = "Object with attributes: `bypass`, `default_action`, `ip_rules`, `virtual_network_subnet_ids`. See https://www.terraform.io/docs/providers/azurerm/r/storage_account.html#network_rules for more information"

  type = object({
    bypass                     = list(string),
    default_action             = string,
    ip_rules                   = list(string),
    virtual_network_subnet_ids = list(string),
  })
}

variable "private_endpoint_properties" {
  description = "The private endpoint properties to add multiple endpoints if needed. Specify subnet, subresource and DNS zone"
  type = list(object({
    subnet_id                    = string
    private_dns_zone_id          = list(string)
    private_endpoint_subresource = string
  }))
}

variable "containers" {
  description = "List of container names"
  type        = list(string)
}

variable "management_policy_rules" {
  description = "Storage account lifecycle management policy rules"
}
