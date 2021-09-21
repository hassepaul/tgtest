
variable "resource_group_name" {
  description = "The resource group name in which to put the virtual machine"
}

variable "location" {
  description = "Specifies the supported Azure location where to create the resource."
}

variable "tags" {
  description = "Tags for this resource"
}

variable "settings" {
  description = "Virtual Machine configuration details"
}

variable "os_disk" {
  description = "Details to create the disk containing the OS install"
}

variable "source_image_reference" {
  description = "Details to deploy from a system image"
}

variable "admin_ssh_key" {
  description = "Block to use SSH logging"
}

variable "network_interfaces" {
  description = "Networking interfaces to attach to this virtual machine"
}

variable "disks" {
  description = "Disks to attach to this virtual  machine."
}

variable "backup" {
  description = "Configuration block containing info about recovery vault and backup policy"
}

variable "availability_set" {
  description = "Configuration block containing availability set details"
}
