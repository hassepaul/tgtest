locals {
  backend_pools_app_services = {
    # Delete to avoid dependencies issues
  }

  backend_pools_fqdn = {
    for key, value in var.application_gateway_applications : key => flatten(
      [
        try(value.backend_pool.fqdns, [])
      ]
    )
  }

  backend_pools = {
    for key, value in var.application_gateway_applications : key => {
      name = try(value.backend_pool.name, value.name)
      /*fqdns = flatten(
        [
          # local.backend_pools_app_services[key],
          try(local.backend_pools_fqdn[key], [])
        ]
      )*/
      ip_addresses = try(value.backend_pool.ip_addresses, null)
    }
  }
}