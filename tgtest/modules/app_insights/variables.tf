
variable "tags" {
  description = "Tags for this resource"
  type        = map
}

variable "resource_group_name" {
  type        = string
  description = "The resource group in which to put the App Insight"
}

variable "location" {
  type        = string
  description = "The resource location"
}

variable "suffix" {
  description = "Suffix to define resource naming"
  type        = list(string)
}

variable "application_type" {
  description = "Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET"
  type        = string
}

variable "retention_days" {
  description = "Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90"
  type        = number
}

variable "sampling_percentage" {
  description = "Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry"
  type        = number
}

variable "disable_ip_masking" {
  description = "By default the real client ip is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client ip"
  type        = bool
}