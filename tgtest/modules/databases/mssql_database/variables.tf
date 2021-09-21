variable suffix {
  type        = list(string)
  description = "naming suffix"
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "sku_name" {
  type        = string
  description = "The SKU name for this MySQL server."
  default     = "BC_Gen5_2"
}

variable "collation" {
  type        = string
  description = "Collation of the DB server"
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "read_scale" {
  type        = bool
  description = "If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica"
  default     = true
}

variable "sql_server_id" {
  type        = string
  description = "MSSQL Server ID"
}

variable "threat_detection_policy" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = list(object(
    {
      disabled_alerts            = list(string)
      email_account_admins       = string
      email_addresses            = list(string)
      retention_days             = number
      state                      = string
      storage_account_access_key = string
      storage_endpoint           = string
      use_server_default         = string
    }
  ))
  default = []
}

variable "long_term_retention_policy" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = list(object(
    {
      monthly_retention = string
      week_of_year      = number
      weekly_retention  = string
      yearly_retention  = string
    }
  ))
  default = []
}

variable "short_term_retention_policy" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = list(object(
    {
      retention_days = number
    }
  ))
  default = []
}

variable "elastic_pool_id" {
  description = "(Optional) Specifies the ID of the elastic pool containing this database."
  default     = null
}

variable "zone_redundant" {
  description = "(Optional) Specifies where the database should be zone redundant."
  default     = false
}

variable "max_size_gb" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "min_capacity" {
  description = "(optional)"
  type        = number
  default     = null
}
