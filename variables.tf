# Optional input variables

variable "kubernetes_version" {
  type        = string
  description = "(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)"
  default = null
}

variable "name" {
  type        = list(string)
  description = " (Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created."
  default     = []
}

variable "dns_prefix" {
  description = " (Required) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created."
  type = string
  default = null
}

variable "location" {
  description = "(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created."
  type = string
}

variable "node_count" {
  description = "(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100 and between min_count and max_count."
  type = string
  default = null
}

variable "agent_pool_name" {
  description = "(Required) The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created."
  default = "default"
  type = string
}

variable "vm_size" {
  description = "(Required) The size of the Virtual Machine, such as Standard_DS2_v2."
  type = string
}

variable "vnet_subnet_id" {
  description = "(Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
  type = string
  default = null
}

variable "max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type = number
  default = 30
}

variable "network_plugin" {
  description = "(Required) Network plugin to use for networking. Currently supported values are azure and kubenet. Changing this forces a new resource to be created."
  default     = "azure"
  type = string
}

variable "service_cidr" {
  description = " (Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created."
  type = string
  default = "10.2.0.0/16"
}

variable "private_cluster_enabled" {
  description = "Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created"
  default = true
  type = bool
}

variable network_policy {
  default = "azure"
  description = "(Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created."
  type = string
}

variable dns_service_ip {
  description = "(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created."
  type = string
  default = "10.2.0.10"
}

variable docker_bridge_cidr {
  default = "172.17.0.1/16"
  type = string
  description = "(Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created."
}

variable load_balancer_type {
  default = "standard"
  description = "(Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are Basic and Standard. Defaults to Standard."
  type = string
}

variable "tags" {
  description = "standard tags"
  type        = map(string)
  default     = {}
}

variable availability_zones {
  description = "(Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
  type = list(string)
  default = null
}

variable resource_group_name {
  description = "(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
  type = string
}
variable "diagnostics_map" {
  description = "(Required) contains the SA and EH details for operations diagnostics"
  type        = map
  default     = null
}

variable "log_analytics_workspace" {
  description = "(Required) contains the log analytics workspace details for operations diagnostics"
  type        = any
  default     = null
}

variable "diagnostics_settings" {
  description = "(Required) configuration object describing the diagnostics"
  type        = any
  default     = null
}

variable "enable_http_app_routing" {
  description = "(Optional) Set to true to enable HTTP application routing"
  type        = bool
  default     = false
}

variable "outbound_type" {
  description = "(Required) The outbound (egress) routing method which should be used for this Kubernetes Cluster"
  type        = string
}