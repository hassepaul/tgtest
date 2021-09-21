
variable "location" {
  description = "The location where to create the resource"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "tags" {
  description = "Tags for this resource"
  type        = map(string)
}

variable "name" {
  description = "Suffix to define resource naming"
  type        = list(string)
}

variable "storage_account_name" {
  description = "(Required) The backend storage account name which will be used by this Function App (such as the dashboard, logs)"
  type        = string
}

variable "storage_account_access_key" {
  description = "(Required) The access key which will be used to access the backend storage account for the Function App"
  type        = string
}

variable "function_app_tier" {
  description = "Tier used in Azure Function Apps"
  type        = string
}

variable "function_app_size" {
  description = "Size used in Azure Web Apps"
  type        = string
}

variable "app_service_plan_id" {
  description = "The ID of the App Service Plan (if exist. If not create one)"
  type        = string
}

variable "function_app_settings" {
  description = "App settings to configure the Function App"
  type        = map
}

variable "function_app_setting_worker_runtime" {
  description = "Type of runtime used by the function (dotnet, java, node, powershell and python)"
  type        = string
}

variable "function_app_site_config" {
  description = "Function App site config options"
  type        = map
}

variable "function_app_site_config_always_on" {
  description = "Enable to get the function loaded at all times"
  type        = bool
}

variable "function_app_site_config_min_tls_version" {
  description = "Minimum supported TLS version. Defaults to 1.2"
  type        = string
}

variable "function_app_site_config_ftps_state" {
  description = "State of FTP / FTPS service for this App Service. Possible values include: AllAllowed, FtpsOnly and Disabled"
  type        = string
}

variable "function_app_site_config_scm_type" {
  description = "SCM type used in Fun Apps"
  type        = string
}

variable "function_app_connection_string" {
  description = "Function connection strings to be stored"
  type        = map
}

variable "function_app_client_affinity_enabled" {
  description = "Client affinity for Function App"
  type        = bool
}

variable "function_app_daily_memory_time_quota" {
  description = "The amount of memory in gigabyte-seconds that your application is allowed to consume per day. Setting this value only affects function apps under the consumption plan."
  type        = number
}

variable "function_app_enabled" {
  description = "Enabling or disabling the function app"
  type        = bool
}

variable "function_app_https_only" {
  description = "Enabling or disabling HTTPS only"
  type        = bool
}

variable "function_app_version" {
  description = "Runtime version for the Function App"
  type        = string
}

variable "function_app_system_identity_enabled" {
  description = "Enable App System Identity to generate a service principal for the function"
  type        = bool
}

variable "function_app_ad_auth_settings" {
  description = "Active Directory Authentication settings"
  type        = any
}

variable "app_insight_retention_days" {
  description = "Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90"
  type        = number
}

variable "app_insight_sampling_percentage" {
  description = "Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry."
  type        = number
}

variable "app_insight_instrumentation_key" {
  description = "The Instrumentation Key for this Application Insights component"
  type        = string
}

variable "app_insight_connection_string" {
  description = "The Connection String for this Application Insights component."
  type        = string
}

# Note: Web App VNEt Integration to be able to access private resource from Web App
# https://docs.microsoft.com/en-us/azure/app-service/web-sites-integrate-with-vnet

variable "subnet_id" {
  description = "The subnet id for VNET integration"
  type        = string
}

variable "private_inbound" {
  description = "Details to setup private endpoint for inbound traffic"
}
