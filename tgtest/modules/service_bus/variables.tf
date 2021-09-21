
variable "suffix" {
  description = "Specifies the name of the ServiceBus Namespace resource"
}

variable "location" {
  description = "The location of the service"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the namespace"
}

variable "sku" {
  description = "The SKU of the Service Bus - Standard or Premium"
}

variable "capacity" {
  description = "Specifies the capacity, only for Premium"
}

variable "zone_redundant" {
  description = "Whether or not this resource is zone redundant"
}

variable "tags" {
  description = "standard tags"
}

variable "queues" {
  description = "List of queues."
}

variable "queue_auth_rules" {
  description = "SAS policies for queues."
}

variable "topics" {
  description = "List of topics."
}

variable "topic_auth_rules" {
  description = "SAS policies for topic."
}

variable "subnet_id" {
  description = "The subnet id of the private endpoint"
}

variable "private_dns_zone_ids" {
  description = "The private dns zones to use with the private endpoint."
}
