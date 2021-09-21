
variable "tags" {
  description = "Tags for this resource"
  type        = map
}

variable "resource_group_name" {
  type        = string
  description = "The resource group in which to put the KeyVault."
}

variable "location" {
  description = "The location where to create the resource"
  type        = string
}

variable "name" {
  description = "Suffix to define resource naming"
  type        = list(string)
}

variable "user_access_policies" {
  description = "List of user access policies for the Key Vault."
  type = list(object({
    users                   = list(string)
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
  }))
}

variable "group_access_policies" {
  description = "List of group access policies for the Key Vault."
  type = list(object({
    groups                  = list(string)
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
  }))
}

variable "app_access_policies" {
  description = "List of app access policies for the Key Vault."
  type = list(object({
    apps                    = list(string)
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
  }))
}

variable "purge_protection" {
  description = "Enable/Disable purge protetion for Key Vault"
  type        = bool
}

variable "sku" {
  description = "SKU for Key Vault. Standard or Premium"
  type        = string
}

variable "enabled_for_deployment" {
  description = "Allow Virtual Machines to retrieve certificates stored as secrets from the key vault."
  type        = bool
}

variable "enabled_for_disk_encryption" {
  description = "Allow Disk Encryption to retrieve secrets from the vault and unwrap keys."
  type        = bool
}

variable "enabled_for_template_deployment" {
  description = "Allow Resource Manager to retrieve secrets from the key vault."
  type        = bool
}

variable "logs_storage_account_id" {
  description = "Storage account ID for logs"
  type        = string
}

variable "logs_storage_retention" {
  description = "Retention in days for logs on Storage Account"
  type        = number
}

variable "network_acls" {
  description = "Object with attributes: `bypass`, `default_action`, `ip_rules`, `virtual_network_subnet_ids`. See https://www.terraform.io/docs/providers/azurerm/r/key_vault.html#bypass for more informations."

  type = object({
    bypass                     = string,
    default_action             = string,
    ip_rules                   = list(string),
    virtual_network_subnet_ids = list(string),
  })
}

variable "subnet_id" {
  description = "The subnet id of the private endpoint."
  type        = string
}

variable "private_dns_zone_ids" {
  description = "The private dns zones to use with the private endpoint."
  type        = list(string)
}

variable "diagnostics_map" {
  description = "(Required) contains the SA and EH details for operations diagnostics"
  type        = map
}

variable "log_analytics_workspace" {
  description = "(Required) contains the log analytics workspace details for operations diagnostics"
  type        = any
}

variable "diagnostics_settings" {
  description = "(Required) configuration object describing the diagnostics"
  type        = any
}

variable "diagnostics_enabled" {
  description = "enables all monitoring diagnostics for the current resource"
  type        = bool
}

variable "secrets" {
  description = "name and value for secrets"
  type        = map
}