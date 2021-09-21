variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "location" {
  description = "location of the resource"
}
variable "settings" {}

variable "tags" {
  default = {}
}