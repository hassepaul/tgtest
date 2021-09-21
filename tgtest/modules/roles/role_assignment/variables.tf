
variable "scope" {
  description = "The scope at which the Role Assignment applies to"
  type        = string
}

variable "role_definition_name" {
  description = "The name of a built-in Role"
  type        = string
}

variable "resources" {
  description = "Map containing one or more Service Principal ID's to assign the Role definition to"
  type        = map
}

variable "ad_apps" {
  description = "Map contaning names of Applications registered on Azure Active Directory"
  type        = map
}

variable "ad_users" {
  description = "Map contaning names of Users registered on Azure Active Directory"
  type        = map
}

variable "ad_groups" {
  description = "Map contaning names of Groups registered on Azure Active Directory"
  type        = map
}