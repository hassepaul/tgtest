# Terraform specific settings

terraform {
  # Pin Terraform version
  required_version = ">= 0.12.26"
  # Pin provider version
  required_providers {
    azurerm = ">= 2.31.0"
  }
}

module "naming" {
  source = "git::ssh://ProdNGAHR@vs-ssh.visualstudio.com/v3/ProdNGAHR/GT%20Cloud/terraform-azurerm-naming?ref=1.0.2"
  suffix = var.name
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                    = module.naming.kubernetes_cluster.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.dns_prefix != null ? var.dns_prefix : module.naming.kubernetes_cluster.name
  private_cluster_enabled = var.private_cluster_enabled
  kubernetes_version      = var.kubernetes_version

  default_node_pool {
    name                 = var.agent_pool_name
    orchestrator_version = var.kubernetes_version
    node_count           = var.node_count
    vm_size              = var.vm_size
    vnet_subnet_id       = var.vnet_subnet_id
    availability_zones   = var.availability_zones
    max_pods             = var.max_pods
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
    load_balancer_sku  = var.load_balancer_type
    outbound_type      = var.outbound_type
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = true
    }

    http_application_routing {
      enabled = var.enable_http_app_routing 
    }

    kube_dashboard {
      enabled = false
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = var.log_analytics_workspace.id 
    }
  }

  tags = var.tags
}


####################################
## Diagnostic Settings Deployment ##
####################################

resource "azurerm_monitor_diagnostic_setting" "aks-diag" {
  count                          = (var.diagnostics_map != null && var.diagnostics_settings != null) ? 1 : 0

  name                           = "diag-${module.naming.kubernetes_cluster.name}"
  target_resource_id             = azurerm_kubernetes_cluster.cluster.id

  log_analytics_workspace_id     = var.log_analytics_workspace.id
  log_analytics_destination_type = lookup(var.diagnostics_settings, "log_analytics_destination_type", null)

  eventhub_name                    = lookup(var.diagnostics_map, "eh_name", null)
  eventhub_authorization_rule_id   = lookup(var.diagnostics_map, "eh_id", null) != null ? "${var.diagnostics_map.eh_id}/authorizationrules/RootManageSharedAccessKey" : null

  storage_account_id               = var.diagnostics_map.diags_sa

  log {
    category = "guard"
    enabled  = false

    retention_policy {
      enabled = false
    }
  }

  dynamic "log" {
    for_each = var.diagnostics_settings.log
    content {
      category = log.value[0]
      enabled  = log.value[1]
      retention_policy {
        enabled = log.value[2]
        days    = log.value[3]
      }
    }
  }

  dynamic "metric" {
    for_each = var.diagnostics_settings.metric
    content {
      category = metric.value[0]
      enabled  = metric.value[1]
      retention_policy {
        enabled = metric.value[2]
        days    = metric.value[3]
      }
    }
  }
}
