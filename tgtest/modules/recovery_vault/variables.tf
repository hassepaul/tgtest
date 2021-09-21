
variable "suffix" {
  description = "Specifies the name of the Recovery Vault resource"
}

variable "location" {
  description = "The location of the service"
}

variable "tags" {
  description = "Tags for this resource"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the namespace"
}

variable "sku" {
  description = "The SKU of the Service Bus - Standard or Premium"
}

variable "virtual_machine_policies" {
  description = "Backup policies for virtual machines"
}
