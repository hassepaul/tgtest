locals {

  hostname_configurations = {
    for key, value in try(var.settings.hostname_configurations, []) : key => value
  }
}

