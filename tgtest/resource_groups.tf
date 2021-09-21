
module "resource_groups" {
  source   = "./modules/resource_group"
  for_each = try(var.resource_groups, {})

  suffix   = concat(try(var.global_settings.suffix, []), each.value.suffix)
  location = try(each.value.location, null) != null ? each.value.location : try(var.global_settings.location, null)
  tags     = merge(try(var.global_settings.tags, {}), try(each.value.tags, {}))
}

output "resource_groups" {
  description = "Output variable containing Resource Group objects"
  value       = module.resource_groups
}
