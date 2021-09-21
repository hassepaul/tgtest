# Naming convention
module "naming" {
  source = "git::ssh://ProdNGAHR@vs-ssh.visualstudio.com/v3/ProdNGAHR/GT%20Cloud/terraform-azurerm-naming?ref=solution"
  suffix = var.name
}



/* data "azurerm_key_vault_certificate" "trustedcas" {
  for_each = {
    for key, value in try(var.settings.trusted_root_certificate, {}) : key => value
    if try(value.keyvault_key, null) != null
  }
  name         = each.value.name
  key_vault_id = var.keyvaults[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.keyvault_key].id
}*/

data "azurerm_key_vault_certificate" "manual_certs" {
  for_each = {
    for key, value in local.listeners : key => value
    if try(value.keyvault_certificate.certificate_name, null) != null
  }
  name         = each.value.keyvault_certificate.certificate_name
  key_vault_id = var.keyvaults[each.value.keyvault_certificate.keyvault_key].id
}

resource "azurerm_application_gateway" "agw" {
  name                = module.naming.application_gateway.name
  resource_group_name = var.resource_group_name
  location            = var.location

  zones              = try(var.settings.zones, null)
  enable_http2       = try(var.settings.enable_http2, true)
  tags               = try(var.tags, null)
  firewall_policy_id = try(var.application_gateway_waf_policies[try(var.settings.waf_policy.key)].id, null)

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = try(var.settings.capacity.autoscale, null) == null ? var.settings.capacity.scale_unit : null
  }

  gateway_ip_configuration {
    name      = module.naming.application_gateway.name
    subnet_id = local.ip_configuration["gateway"].subnet_id
  }

  dynamic "autoscale_configuration" {
    for_each = try(var.settings.capacity.autoscale, null) == null ? [] : [1]

    content {
      min_capacity = var.settings.capacity.autoscale.minimum_scale_unit
      max_capacity = var.settings.capacity.autoscale.maximum_scale_unit
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.settings.front_end_ip_configurations

    content {
      name                 = frontend_ip_configuration.value.name
      public_ip_address_id = try(local.ip_configuration[frontend_ip_configuration.key].ip_address_id, null)
      //private_ip_address            = try(frontend_ip_configuration.value.public_ip_key, null) == null ? local.private_ip_address : null
      //private_ip_address_allocation = try(frontend_ip_configuration.value.private_ip_address_allocation, null)
      //subnet_id                     = local.ip_configuration[frontend_ip_configuration.key].subnet_id
    }
  }

  dynamic "frontend_port" {
    for_each = var.settings.front_end_ports

    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "http_listener" {
    for_each = local.listeners

    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = var.settings.front_end_ip_configurations[http_listener.value.front_end_ip_configuration_key].name
      frontend_port_name             = var.settings.front_end_ports[http_listener.value.front_end_port_key].name
      protocol                       = var.settings.front_end_ports[http_listener.value.front_end_port_key].protocol
      host_name                      = try(trimsuffix((try(http_listener.value.host_names, null) == null ? try(http_listener.value.host_name) : null), "."), null)
      host_names                     = try(http_listener.value.host_name, null) == null ? try(http_listener.value.host_names, null) : null
      require_sni                    = try(http_listener.value.require_sni, false)
      ssl_certificate_name           = try(data.azurerm_key_vault_certificate.manual_certs[http_listener.key].name, null)
      //firewall_policy_id             = try(var.application_gateway_waf_policies[try(http_listener.value.waf_policy.lz_key, var.client_config.landingzone_key)][http_listener.value.waf_policy.key].id, null)
    }
  }


  # HTTP to HTTPS redirect listeners
  dynamic "http_listener" {
    for_each = local.https_redirect_listeners

    content {
      name = "redirect-to-https-${http_listener.value.name}"
      frontend_ip_configuration_name = var.settings.front_end_ip_configurations[http_listener.value.front_end_ip_configuration_key].name
      frontend_port_name             = "http"
      protocol                       = "Http"
      host_name                      = try(trimsuffix((try(http_listener.value.host_names, null) == null ? try(http_listener.value.host_name) : null), "."), null)
      host_names                     = try(http_listener.value.host_name, null) == null ? try(http_listener.value.host_names, null) : null
    }
  }

  dynamic "request_routing_rule" {
    for_each = local.listeners

    content {
      name                       = "${try(local.request_routing_rules[format("%s-%s", request_routing_rule.value.app_key, request_routing_rule.value.request_routing_rule_key)].rule.prefix, "")}${request_routing_rule.value.name}"
      rule_type                  = try(local.request_routing_rules[format("%s-%s", request_routing_rule.value.app_key, request_routing_rule.value.request_routing_rule_key)].rule.rule_type, "Basic")
      http_listener_name         = request_routing_rule.value.name
      backend_http_settings_name = local.backend_http_settings[request_routing_rule.value.app_key].name
      backend_address_pool_name  = local.backend_pools[request_routing_rule.value.app_key].name
      url_path_map_name = try(local.request_routing_rules[format("%s-%s", request_routing_rule.value.app_key, request_routing_rule.value.request_routing_rule_key)].rule.url_path_map_name, try(local.url_path_maps[format("%s-%s", request_routing_rule.value.app_key,
      local.request_routing_rules[format("%s-%s", request_routing_rule.value.app_key, request_routing_rule.value.request_routing_rule_key)].rule.url_path_map_key)].name, null))


    }
  }

  dynamic "request_routing_rule" {
    for_each = local.https_redirect_listeners

    content {
      name                       = "redirect-to-https-${request_routing_rule.value.name}"
      rule_type                  = "Basic"
      http_listener_name         = "redirect-to-https-${request_routing_rule.value.name}"
      redirect_configuration_name = "sslr-${request_routing_rule.value.name}"
    }
  }

  dynamic "url_path_map" {
    for_each = try(local.url_path_maps)
    content {
      default_backend_address_pool_name  = try(url_path_map.value.default_backend_address_pool_name, var.application_gateway_applications[url_path_map.value.app_key].name)
      default_backend_http_settings_name = try(url_path_map.value.default_backend_http_settings_name, var.application_gateway_applications[url_path_map.value.app_key].name)
      name                               = url_path_map.value.name

      dynamic "path_rule" {
        for_each = try(url_path_map.value.path_rules, [])

        content {
          backend_address_pool_name  = try(var.application_gateway_applications[path_rule.value.backend_pool.app_key].name, var.application_gateway_applications[path_rule.value.backend_pool.app_key].name)
          backend_http_settings_name = try(var.application_gateway_applications[path_rule.value.backend_http_setting.app_key].name, var.application_gateway_applications[url_path_map.value.app_key].name)
          name                       = path_rule.value.name
          paths                      = path_rule.value.paths
        }
      }
    }
  }

  dynamic "probe" {
    for_each = try(local.custom_probes)
    content {
      name                                      = var.application_gateway_applications[probe.key].name
      protocol                                  = probe.value.protocol
      port                                      = try(probe.value.port, null)
      interval                                  = try(probe.value.interval, 30)
      path                                      = try(probe.value.path, "/")
      timeout                                   = try(probe.value.timeout, 30)
      unhealthy_threshold                       = try(probe.value.unhealthy_threshold, 3)
      pick_host_name_from_backend_http_settings = try(probe.value.pick_host_name_from_backend_http_settings, false)
      host                                      = try(probe.value.pick_host_name_from_backend_http_settings, false) == false ? try(probe.value.host, null) : null
      minimum_servers                           = try(probe.value.minimum_servers, null)

      match {
        status_code = try(probe.value.status_code, ["200-399"])
        body        = try(probe.value.body, "")
      }

    }
  }

  dynamic "backend_http_settings" {
    for_each = local.backend_http_settings

    content {
      name                                = var.application_gateway_applications[backend_http_settings.key].name
      cookie_based_affinity               = try(backend_http_settings.value.cookie_based_affinity, "Disabled")
      port                                = backend_http_settings.value.port
      protocol                            = backend_http_settings.value.protocol
      request_timeout                     = try(backend_http_settings.value.request_timeout, 30)
      pick_host_name_from_backend_address = try(backend_http_settings.value.pick_host_name_from_backend_address, false)
      host_name                           = try(backend_http_settings.value.pick_host_name_from_backend_address, false) == false ? try(backend_http_settings.value.host_name, null) : null
      trusted_root_certificate_names      = try(backend_http_settings.value.trusted_root_certificate_names, null)
      probe_name                          = try(local.custom_probes[backend_http_settings.key].name, null)
    }
  }

  dynamic "backend_address_pool" {
    for_each = local.backend_pools

    content {
      name         = var.application_gateway_applications[backend_address_pool.key].name
      fqdns        = try(backend_address_pool.value.fqdns, null)
      ip_addresses = try(backend_address_pool.value.ip_addresses, null)
    }
  }

  /* dynamic "identity" {
    for_each = try(var.settings.identity, null) == null ? [] : [1]

    content {
      type         = "UserAssigned"
      identity_ids = local.managed_identities
    }

  }*/

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.agw_user_managed_identity.id]
  }

  # authentication_certificate {

  # }



  dynamic "trusted_root_certificate" {
    for_each = {
      for key, value in try(var.settings.trusted_root_certificate, {}) : key => value
    }
    content {
      name = trusted_root_certificate.value.name
      data = try(trusted_root_certificate.value.data, data.azurerm_key_vault_certificate.trustedcas[trusted_root_certificate.key].certificate_data_base64)
    }
  }


  ssl_policy {
    policy_type          = try(var.settings.ssl_policy.policy_type, "Predefined")
    cipher_suites        = try(var.settings.ssl_policy.policy_type, null) == "Custom" ? try(var.settings.ssl_policy.cipher_suites, []) : []
    min_protocol_version = try(var.settings.ssl_policy.policy_type, null) == "Custom" ? try(var.settings.ssl_policy.min_protocol_version, null) : null
    policy_name          = try(var.settings.ssl_policy.policy_name, "AppGwSslPolicy20170401S")
  }



  dynamic "ssl_certificate" {
    for_each = try(local.certificate_keys)

    content {
      name                = ssl_certificate.value
      key_vault_secret_id = var.keyvault_certificates[ssl_certificate.value].secret_id
      # data     = try(ssl_certificate.value.key_vault_secret_id, null) == null ? ssl_certificate.value.data : null
      # password = try(ssl_certificate.value.data, null) != null ? ssl_certificate.value.password : null
    }
  }

  dynamic "ssl_certificate" {
    for_each = try(local.certificate_request_keys)

    content {
      name                = ssl_certificate.value
      key_vault_secret_id = var.keyvault_certificate_requests[ssl_certificate.value].secret_id
    }
  }

  dynamic "ssl_certificate" {
    for_each = try(data.azurerm_key_vault_certificate.manual_certs)

    content {
      name                = ssl_certificate.value.name
      key_vault_secret_id = ssl_certificate.value.secret_id
    }
  }


  # waf_configuration {}

  # custom_error_configuration {}

  dynamic "redirect_configuration" {
    for_each = local.https_redirect_listeners

    content {
      name = "sslr-${redirect_configuration.value.name}"
      redirect_type = "Permanent"
      target_listener_name = redirect_configuration.value.name
      include_path = true
      include_query_string = true
    }
  }

  # autoscale_configuration {}

  # rewrite_rule_set {}


}


#####################
## Manage Identity ##
#####################

resource "azurerm_user_assigned_identity" "agw_user_managed_identity" {
  name                = module.naming.application_gateway.name
  resource_group_name = var.resource_group_name
  location            = var.location
}