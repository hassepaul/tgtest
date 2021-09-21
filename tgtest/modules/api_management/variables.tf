variable "name" {
  description = "Specifies the name of the API Management resource"
}

variable "settings" {}

/*variable "client_config" {
  description = "Client configuration object (see module README.md)."
}*/

//variable "diagnostics" {}

variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "sku_name" {
  description = "(Optional) (Default = Developer_1) The Name of the SKU to use for this APIM."
  type        = string
  default     = "Developer_1"
}

variable "publisher_name" {
  description = "The name of publisher/company."
  type        = string
}

variable "publisher_email" {
  description = "The name of publisher/company."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+", var.publisher_email))
    error_message = "Provide an email in a valid format (i.e. abcd@domain.com)."
  }
}



