
variable "location" {
  type        = string
  description = "The location where the resource group will be created."
}

variable "suffix" {
  type        = list(string)
  description = "A naming suffix to be used in the creation of unique names for Azure resources."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
}