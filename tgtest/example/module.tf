
module "example" {
  source = "../"

  global_settings              = var.global_settings
  resource_groups              = var.resource_groups
  aks_clusters                 = var.aks_clusters
  appservice_plans             = var.appservice_plans
  functionapps                 = var.functionapps
  service_bus                  = var.service_bus
  mssql_servers                = var.mssql_servers
  mssql_pools                  = var.mssql_pools
  mssql_databases              = var.mssql_databases
  redis_clusters               = var.redis_clusters
  storage_accounts             = var.storage_accounts
  keyvaults                    = var.keyvaults
  appinsights                  = var.appinsights
  virtual_machines             = var.virtual_machines
  recovery_vaults              = var.recovery_vaults
  mysql_servers                = var.mysql_servers
  apis_management              = var.apis_management
  appservices                  = var.appservices
  data_factory                 = var.data_factory
  data_factory_linked_services = var.data_factory_linked_services
}

output "example" {
  value = module.example
}
