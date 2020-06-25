# Terraform specific settings

terraform {
  # Pin Terraform version
  required_version = ">= 0.12.26"
  # Pin provider version
  required_providers {
    azurerm = "~> 2.15.0"
  }
}

module "rg" {
  source = "git::ssh://ProdNGAHR@vs-ssh.visualstudio.com/v3/ProdNGAHR/GT%20Cloud/tf-azurerm-mod-resource-group"
  suffix = var.name
  location = var.location
}


module "naming" {
  source = "git::ssh://ProdNGAHR@vs-ssh.visualstudio.com/v3/ProdNGAHR/GT%20Cloud/terraform-azurerm-naming?ref=v1.0.1"
  suffix = var.name
}

resource "azurerm_resource_group" "aks" {
  name     = module.rg.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                    = module.naming.kubernetes_cluster.name
  location                = var.location
  resource_group_name     = azurerm_resource_group.aks.name
  dns_prefix              = var.dns_prefix
  private_cluster_enabled = var.private_cluster_enabled
  default_node_pool {
    name               = var.agent_pool_name
    node_count         = var.node_count
    vm_size            = var.vm_size
    vnet_subnet_id     = var.vnet_subnet_id
    availability_zones = var.availability_zones
    max_pods           = var.max_pods
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
    load_balancer_sku  = var.load_balancer_type
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  tags = var.default_tags
}
