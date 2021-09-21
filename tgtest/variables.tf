
variable "global_settings" {
  description = "Common settings for all components within a solution, which can be overrided per component"
  default     = {}
}

# Example usage:
#
# global_settings = {
#   suffix   = ["example", "p", "weu"]     <-- suffixes are always concatenated with resource ones
#   location = local.location
#   tags = {
#     serviceOwner = "Some team"
#     environment  = "${local.env}"
#     costCenter   = "GB762"
#     serviceName  = "hrX Suite"
#     deployedBy   = "Terraform"
#   }
# }

variable "resource_groups" {
  description = "Resource groups configuration objects"
  default     = {}
}

# Example usage:
#
# resource_groups = {
#   rg1 = {                             <-- key for indexing in state and lookup
#     suffix   = ["example", "01"]          <-- resource naming, concatenated after global's
#     location = local.location         <-- will override global_settings
#     tags = {}                         <-- will be merged with global_settings
#   }
#   rg2 = {
#     ...
#   }
# }

variable "aks_clusters" {
  description = "AKS clusters configuration objects"
  default     = {}
}

/* Example usage:

  aks_clusters = {
      aks1 = {                                      <-- key for indexing in state and lookup
        resource_group_key      = "rg1"             <-- key reference to get resource group name (in the same solution)
        suffix                  = ["01"]            <-- resource naming, concatenated after global's
        location = local.location                   <-- will override global_settings
        kubernetes_version      = "1.20.5"
        node_count              = 2
        availability_zones      = ["1", "2"]
        vm_size                 = "Standard_D4s_v3"
        outbound_type           = "userDefinedRouting"
        node_resource_group_name = ["aks", "01"]

        ....
        
      }
    
  } 
 */

variable "appservice_plans" {
  description = "Application Service Plans configuration objects"
  default     = {}
}

/* Example usage:

  appservice_plans = {
      asp1 = {                                          <-- key for indexing in state and lookup
        resource_group_key  = "rg1"                     <-- key reference to get resource group name (in the same solution)
        suffix              = ["example", "01"]          <-- resource naming, concatenated after global's
        kind                = "FunctionApp"
        tier                = "Standard"
        size                = "S3"
      }

      ...
    }
*/

variable "functionapps" {
  description = "Function Apps configuration objects"
  default     = {}
}

/* Example usage:

  functionapps = {
      f1 = {                                                     <-- key for indexing in state and lookup
        resource_group_key  = "rg1"                              <-- key reference to get resource group name (in the same solution)
        asp_key             = "asp1"                             <-- key reference to get app service plan (in the same solution)
        app_insight_key     = "appi1"                            <-- key reference to get app insight  (in the same solution)
        suffix              = ["pay", "01"]                      <-- resource naming, concatenated after global's
        function_app_system_identity_enabled = true
        storage_account_key = "sa1"                               <-- key reference to get storage account (in the same solution)
        subnet_id = dependency.spoke.outputs.subnets.asp-pay-sub
      }

      ...

    }
*/

variable "service_bus" {
  description = "Service Bus configuration objects"
  default     = {}
}

/* Example usage:

  service_bus = {
      sb1 = {                                                                 <-- key for indexing in state and lookup
        resource_group_key   = "rg1"                                          <-- key reference to get resource group name (in the same solution)
        suffix               = ["01"]                                         <-- resource naming, concatenated after global's
        sku                  = "Premium"
        capacity             = 1
        subnet_id            = dependency.spoke.outputs.subnets.pe-sub
        private_dns_zone_ids = [dependency.dns_sb.outputs.private_dns_zone_id]

        queues = {
          # hrX Calc/Pay
          q1  = { name = "adminqueue-out", max_size = 1024 }
          
          ...

        queue_auth_rules = {
            ....
        }
      }

      ...
    }
*/

variable "mssql_servers" {
  description = "MS SQL Servers configuration objects"
  default     = {}
}

/* Example usage:

 mssql_servers = {
    s1 = {                                                                    <-- key for indexing in state and lookup
      resource_group_key   = "rg1"                                            <-- key reference to get resource group name (in the same solution)
      suffix               = ["01"]                                           <-- resource naming, concatenated after global's
      location             = local.region_vars.locals.azure_region
      password             = "########"
      subnet_id            = dependency.spoke.outputs.subnets.db-sub
      private_dns_zone_ids = [dependency.dns_db.outputs.private_dns_zone_id]
      storage_account_key   = "sa1"                                           <-- key reference to get storage account (in the same solution)
    }

    ...
  }

*/

variable "mssql_pools" {
  description = "MS SQL Pools configuration objects"
  default     = {}
}

/* Example usage:

mssql_pools = {
    p1 = {                                                            <-- key for indexing in state and lookup
      resource_group_key = "rg1"                                      <-- key reference to get resource group name (in the same solution)
      suffix             = ["01"]                                     <-- resource naming, concatenated after global's
      location           = local.region_vars.locals.azure_region
      mssql_servers_key  = "s1"                                       <-- key reference to get database server (in the same solution)
      max_size_gb        = "50"
      sku_name           = "StandardPool"
      sku_tier           = "Standard"
      sku_capacity       = "100"
      pds_min_capacity   = "0"
      pds_max_capacity   = "50"
    }
  
    ...
  }
*/

variable "mssql_databases" {
  description = "MS SQL Databases configuration objects"
  default     = {}
}

/* Example usage:

 mssql_databases = {
    db1 = {
      suffix           = ["config", "01"]
      mssql_server_key = "s1"
      elastic_pool_key = "p1"
      sku_name         = "ElasticPool"
      short_term_retention_policy = [{retention_days = 7}]
    }
  }

*/

variable "redis_clusters" {
  description = "Redis clusters configuration objects"
  default     = {}
}

/* Example usage, dependencies resolved at Terragrunt level:

 redis_clusters = {
   redis1 = {                            <-- key for indexing in state and lookup
     suffix             = ...            <-- resource naming
     resource_group_key = "rg1"          <-- matches a key in "resource_groups"
     family             = ...
     capacity           = ...
     ...
     subnet_id          = dependency.spoke.outputs.subnets.redis-sub
     diagnostics_map    = dependency.diagnostic_resources.outputs.diagnostics_map
   }
   redis2 = {
     ...
     location = ...
     tags     = { ... }
   }
 }
*/

variable "storage_accounts" {
  description = "Storage accounts configuration objects"
  default     = {}
}

/* Example usage, dependencies resolved at Terragrunt level:
 storage_accounts = {
    sa1 = {                                                                        <-- key for indexing in state and lookup
      resource_group_key       = "rg1"                                             <-- key reference to get resource group name (in the same solution)
      suffix                   = ["sql", "01"]                                     <-- resource naming, concatenated after global's
      private_endpoint_properties = [
        {
          subnet_id = dependency.spoke.outputs.subnets.pe-sub
          private_dns_zone_id = [dependency.dns_blob.outputs.private_dns_zone_id]
          private_endpoint_subresource = "blob"
        }
      ]
    }

    ...
  }

*/

variable "keyvaults" {
  description = "KeyVaults configuration objects"
  default     = {}
}

/* Example usage, dependencies resolved at Terragrunt level:

 keyvaults = {
   kv1 = {                                <-- key for indexing in state and lookup
     suffix              = ...            <-- resource naming
     resource_group_key  = "rg1"          <-- matches a key in "resource_groups"
     sku                 = ...
     usr_access_policies = ...
     ...
     subnet_id            = dependency.spoke.outputs.subnets.redis-sub
     private_dns_zone_ids = [dependency.dns.outputs.private_dns_zone_id]
     diagnostics_map      = dependency.diagnostic_resources.outputs.diagnostics_map
   }
   kv2 = {
     ...
     location = ...
     tags     = { ... }
   }
 }
*/

variable "appinsights" {
  description = "App Insights configuration objects"
  default     = {}
}

/* Example usage:

appinsights = {
    appi1 = {                                       <-- key for indexing in state and lookup
      resource_group_key  = "rg1"                   <-- key reference to get resource group name (in the same solution)
      suffix              = ["example", "01"]       <-- resource naming, concatenated after global's
    }

    ...
  }
*/

variable "application_gateways" {
  description = "Application Gateways configuration objects"
  default     = {}
}

/* Example usage:

  application_gateways = {
      agw_nonprd = {                                                                  <-- key for indexing in state and lookup
        resource_group_key  = "public_ingress_rg1"                                    <-- key reference to get resource group name (in the same solution)
        suffix              = ["example", "t", "weu", "public", "ingress", "01"]          <-- resource naming, concatenated after global's
        subnet_id           =  dependency.hub.outputs.subnets.external-agw-sub

        sku_name            = "WAF_v2"
        sku_tier            = "WAF_v2"
        capacity = {
          autoscale = {
            minimum_scale_unit = 0
            maximum_scale_unit = 10
          }
        }
        zones        = ["1","2","3"]
        enable_http2 = true
        waf_policy = {
          key = "waf_test_policy"                                                     <-- key reference to WAF policy (in the same solution)
        }

        front_end_ip_configurations = {
          public = {
            name          = "public"
            public_ip_key = "non_prd_agw_pip1"                                        <-- key reference to Public IP (in the same solution)
          }      
       }

        front_end_ports = {
          80 = {
            name     = "http"
            port     = 80
            protocol = "Http"
          }
          443 = {
            name     = "https"
            port     = 443
            protocol = "Https"
          }
        }        
      }

      ...
    }

*/

variable "application_gateway_applications" {
  description = "Application Gateway applications configuration objects"
  default     = {}
}

/* Example usage:

  application_gateway_applications = {
        ingress_test = {                                                              <-- key for indexing in state and lookup

          application_gateway_key = "agw_nonprd"                                      <-- key reference to app gateway (in the same solution)
          name                    = "ingress_test"

          listeners = {
            public_ssl = {
              name                           = "exampletst-public"
              front_end_ip_configuration_key = "public"
              front_end_port_key             = "443"
              host_name                      = "example.eu.cybot.com"
              request_routing_rule_key       = "default"
              keyvault_certificate = {
                // To use manual uploaded cert
                certificate_name = "example-cybot-com"
                keyvault_key     = "cert_kv"                                          <-- key reference to keyvault (in the same solution)
              }
            }
          }

          request_routing_rules = {
            default = {
              rule_type = "Basic"
            }
          }

          backend_http_setting = {
            port                                = 443
            protocol                            = "Https"
            host_name                           = "examplee.eu.cybot.com"                  
          }

          custom_probe = {
            protocol = "Https"
            interval = 10
            pick_host_name_from_backend_http_settings = true                                
          }

          backend_pool = {
            ip_addresses = [
                  "10.25.2.4"
            ]
          }
        }

      ...
    }
*/

variable "application_gateway_waf_policies" {
  description = "Application Gateway WAF policies configuration objects"
  default     = {}
}

/* Example usage:

  application_gateway_waf_policies = {
      waf_test_policy = {                                                           <-- key for indexing in state and lookup
        name               = "waf-example-t-weu-public-ingress-01"                      <-- name
        resource_group_key = "public_ingress_rg1"                                   <-- key reference to get resource group name (in the same solution)

        policy_settings = {
          enabled                     = true
          mode                        = "Detection"
          request_body_check          = true
          file_upload_limit_in_mb     = 100
          max_request_body_size_in_kb = 128
        }

        managed_rules = {          
          managed_rule_set = {
            mrs1 = {
              type    = "OWASP"
              version = "3.2"              
            }
          }
        }
      }

      ...
    }
*/

variable "role_assignments" {
  description = "Role Assignment configuration objects"
  default     = {}
}

/* Example usage:

 role_assignments = {
    ra1 = {                                                                    <-- key for indexing in state and lookup
      scope = dependency.example.outputs.storage_accounts.sa1.id
      role_definition_name = "Storage Blob Data Contributor"

      resources  = {
        r1 = dependency.example.outputs.x.functionapps.f2.principal_id
        r2 = dependency.example.outputs.x.functionapps.f3.principal_id
        r3 = dependency.example.outputs.x.functionapps.f4.principal_id
        r4 = dependency.example.outputs.x.functionapps.f5.principal_id
        r5 = dependency.example.outputs.x.functionapps.f6.principal_id
        r6 = dependency.example.outputs.x.functionapps.f7.principal_id
        r7 = dependency.example.outputs.x.functionapps.f9.principal_id
        r8 = dependency.example.outputs.x.functionapps.f10.principal_id
        r9 = dependency.example.outputs.x.functionapps.f11.principal_id
      }

      ad_apps = {
        a1 = "example-AdministrationAPI-TST"
      }
    }

    ...
  }
*/

variable "public_ip_addresses" {
  description = "Public IP addresses configuration objects"
  default     = {}
}

/* Example usage:

  public_ip_addresses = {
        non_prd_agw_pip1 = {                                                                  <-- key for indexing in state and lookup
            suffix                  = ["agw","example", "t", "weu", "public", "ingress", "01"]    <-- resource naming, concatenated after global's
            resource_group_key      = "public_ingress_rg1"                                    <-- key reference to get resource group name (in the same solution)
            sku                     = "Standard"
            allocation_method       = "Static"
        }
      ...
    }
*/

variable "virtual_machines" {
  description = "Virtual Machines configuration objects"
  default     = {}
}

/* Example usage:

virtual_machines = {                                           
    vm1 = {                                                      <-- key for indexing in state and lookup
      resource_group_key = "rg1"                                 <-- key reference to get resource group name (in the same solution)
                                                                 

      settings = {                                                # settings map, containing main vm features
        os_type        = "linux"                                  # (required) linux or windows?
        name           = "hosazr01lab01"                          # (required) name visible on the portal
        computer_name  = "hosazr01lab01"                          # (required) name configured inside the vm
        size           = "Standard_B1ms"                          # (required) vm size
        admin_username = XXXXX                                    # user and password
        admin_password = XXXXX
      }
      os_disk = {                                                 # os_disk map, contains the installation disk details
        name                 = "dsk-01-hosazr01lab01"             # (required) disk name
        storage_account_type = "Standard_LRS"                     # (required) disk type, i.e std vs premium?
        caching              = "ReadWrite"
      }
      source_image_reference = {                                  # when using a system image from Azure,
        publisher = "Canonical"                                   # provide all the details on vendor, version etc
        offer     = "0001-com-ubuntu-minimal-focal-daily"
        sku       = "minimal-20_04-daily-lts-gen2"
        version   = "latest"
      }
      network_interfaces = {                                      # nics details
        nic1 = {
          name      = "nic-01-hosazr01lab01"                      # (required) nic name
          subnet_id = dependency.spoke.outputs.subnets.vm-sub     # (required) subnet where to create this nic on,
        }                                                         # depends on network spoke which is normally
      }                                                           # defined separately

      backup = {                                                
        resource_group_key = "rg1"                                <-- key to reference the rg where the rsv is placed
        recovery_vault_key = "rv1"                                <-- key to reference the rsv object
        policy_key         = "bv1"                                <-- the backup policy within rsv we want to set
      }
    }
  }
*/

variable "recovery_vaults" {
  description = "Recovery Vaults configuration objects"
  default     = {}
}

/* Example usage:

recovery_vaults = {                                             
   rv1 = {                                                        <-- key for indexing in state and lookup
     resource_group_key = "rg1"                                   <-- key reference to get resource group name (in the same solution)

     suffix = ["01"]                                              <-- resource naming, concatenated after global's
     sku    = "Standard"                                          # rsv tier

     virtual_machine_policies = {                                 # policies relative to vms
       bv1 = {                                                    # key to identify policy on the state
         name     = "production-nightly"                          # policy name
         timezone = "UTC"                                         # scheduling and retention details
         backup = {
           frequency = "Daily"
           time      = "23:00"
         }
         retention_daily = {
           count = 30
         }
       }
     }

   }
 }
*/

variable "mysql_servers" {
  description = "MySQL Servers configuration objects"
  default     = {}
}

/* Example usage:

 mysql_servers = {
    s1 = {                                                      <-- key for indexing in state and lookup
      resource_group_key   = "rg1"                              <-- key reference to get resource group name (in the same solution)
      suffix               = ["01"]                             <-- resource naming, concatenated after global's
      server_config = {
        admin_user           = xxxxx
        admin_password       = xxxxx
        sku_name             = "GP_Gen5_2"
        version              = "8.0"
        storage_mb           = 5120
        backup_retention     = 9
        geo_redundant_backup = false
      }
      subnet_id            = dependency.spoke.outputs.subnets.db-sub
      private_dns_zone_ids = [dependency.dns_mysql.outputs.private_dns_zone_id]
    }
  }
*/

variable "apis_management" {
  description = "APIs Management configuration objects"
  default     = {}
}

/* Example usage:

  apis_management = {
      apim1 = {                                                         <-- key for indexing in state and lookup
               
        suffix = ["example", "d", "weu", "01"]                              <-- resource naming, concatenated after global's
        resource_group_key = "rg1"                                      <-- key reference to get resource group name (in the same solution)
        
        publisher_name      = "Alight"
        publisher_email     = "mail@company.com"
        sku_name            = "Developer_1"

        virtual_network_configuration = {
            type      = "Internal"
            subnet_id = dependency.spoke.outputs.subnets.apim-sub
        }

        sign_up = {
            enabled = true
            terms_of_service = {
                consent_required = true
                enabled = true
                text = "Consent text here"
            }
        }

        identity = {
            type = "SystemAssigned"
        }

        ...

      }

    ...
  }
*/

variable "appservices" {
  description = "App Services (Web Apps) configuration objects"
  default     = {}
}

/* Example usage:

  appservices = {
    a1 = {                                                                <-- key for indexing in state and lookup
      resource_group_key  = "rg1"                                         <-- key reference to get resource group name (in the same solution)
      asp_key             = "asp1"                                        <-- other key references
      app_insight_key     = "appi1"                                             "    "
      suffix              = ["hrxassist", "coreapi", "01"]                <-- resource naming, concatenated after global's

      app_settings = {
        "SOME_KEY" = "some-value"
      }

      site_config = {
        dotnet_framework_version = "v4.0"
        scm_type                 = "LocalGit"
      }

      backup = {                                                          <-- if backups are required, storage account details are needed;
        storage_account_key = "sa99"                                          one way is using the key reference and the wrapper will add the
        container_name = "backups"                                            necessary details automatically; or these can also be passed from
        schedule = { ... }                                                    here if they are defined elsewhere (with terragrunt dependencies)
      }

      subnet_id           = dependency.spoke.outputs.subnets.asp-assist-sub              <-- to integrate with the vnet to reach private resources
      private_inbound     = {                                                            <-- to make inbound private
        subnet_id                     = dependency.spoke.outputs.subnets.pe-sub
        private_dns_zone_ids          = [dependency.dns_web.outputs.private_dns_zone_id]
        private_endpoint_subresources = ["sites"]
      }
    }
  }

*/

variable "data_factory" {
  description = "Data Factory configuration objects"
  default     = {}
}

variable "data_factory_linked_services" {
  description = "Data Factory Linked Services configuration objects"
  default     = {}
}

variable "security_center" {
  description = "Security Center configuration objects"
  default     = {}
}
