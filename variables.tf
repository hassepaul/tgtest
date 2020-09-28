# Optional input variables

variables kubernetes_version {
  type        = string
  description = "Kubernetes version"
}

variable "name" {
  type        = list(string)
  description = "A naming prefix to be used in the creation of unique names for Azure resources."
  default     = []
}

variable "dns_prefix" {
  description = "DNS prefix"
  type = string
}

variable "location" {
  description = "azure location to deploy resources"
  type = string
}

variable "node_count" {
  description = "number of nodes to deploy"
  type = string
}

variable "agent_pool_name" {
  description = "name of node pool"
  default = "default"
  type = string
}

variable "vm_size" {
  description = "size/type of VM to use for nodes"
  type = string
}

variable "vnet_subnet_id" {
  description = "vnet id where the nodes will be deployed"
  type = string
}

variable "max_pods" {
  description = "maximum number of pods that can run on a single node"
  type = number
}

variable "network_plugin" {
  description = "network plugin for kubenretes network overlay (azure or calico)"
  default     = "azure"
  type = string
}

variable "service_cidr" {
  description = "kubernetes internal service cidr range"
  type = string
}

variable private_cluster_enabled {
  description = "true for private cluster"
  default = true
  type = bool
}

variable network_policy {
  default = "azure"
}

variable dns_service_ip {
  description = "dns service ip"
  type = string
}

variable docker_bridge_cidr {
  default = "172.17.0.1/16"
  type = string
  description = "docker bridge cidr"
}

variable load_balancer_type {
  default = "standard"
}

variable "default_tags" {
  description = "standard tags"
  type        = map(string)
  default     = {}
}

variable availability_zones {
  description = "zones where the nodes should be deployed"
  type = list(string)
}

variable resource_group_name {
  description = "Name of resource group"
  type = string
}
