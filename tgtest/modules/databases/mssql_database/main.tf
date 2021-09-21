# Naming

module "naming" {
  source = "../../../modules/naming"
  suffix = var.suffix
}

resource "azurerm_mssql_database" "sql_database" {
  name            = module.naming.mssql_database.name
  server_id       = var.sql_server_id
  elastic_pool_id = var.elastic_pool_id
  collation       = var.collation
  max_size_gb     = var.max_size_gb
  min_capacity    = var.min_capacity
  read_scale      = var.read_scale
  sku_name        = var.sku_name // BC_Gen5_2 - Business Critical
  zone_redundant  = var.zone_redundant
  tags            = var.tags

  dynamic "short_term_retention_policy" {
    for_each = var.short_term_retention_policy
    content {
      retention_days = short_term_retention_policy.value["retention_days"]
    }
  }

  dynamic "long_term_retention_policy" {
    for_each = var.long_term_retention_policy
    content {
      monthly_retention = long_term_retention_policy.value["monthly_retention"]
      week_of_year      = long_term_retention_policy.value["week_of_year"]
      weekly_retention  = long_term_retention_policy.value["weekly_retention"]
      yearly_retention  = long_term_retention_policy.value["yearly_retention"]
    }
  }

  dynamic "threat_detection_policy" {
    for_each = var.threat_detection_policy
    content {
      disabled_alerts            = threat_detection_policy.value["disabled_alerts"]
      email_account_admins       = threat_detection_policy.value["email_account_admins"]
      email_addresses            = threat_detection_policy.value["email_addresses"]
      retention_days             = threat_detection_policy.value["retention_days"]
      state                      = threat_detection_policy.value["state"]
      storage_account_access_key = threat_detection_policy.value["storage_account_access_key"]
      storage_endpoint           = threat_detection_policy.value["storage_endpoint"]
      use_server_default         = threat_detection_policy.value["use_server_default"]
    }
  }
}
