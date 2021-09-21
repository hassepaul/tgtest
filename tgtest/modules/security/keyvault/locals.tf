
locals {

  flatten_user_access_policies = flatten([for user_access_policy in var.user_access_policies :
    [for u in user_access_policy.users : {
      user                    = u
      key_permissions         = user_access_policy.key_permissions
      secret_permissions      = user_access_policy.secret_permissions
      certificate_permissions = user_access_policy.certificate_permissions
    }]
  ])

  user_access_policies_map = { for policy in local.flatten_user_access_policies : policy.user => policy }

  flatten_group_access_policies = flatten([for group_access_policy in var.group_access_policies :
    [for g in group_access_policy.groups : {
      group                   = g
      key_permissions         = group_access_policy.key_permissions
      secret_permissions      = group_access_policy.secret_permissions
      certificate_permissions = group_access_policy.certificate_permissions
    }]
  ])

  group_access_policies_map = { for policy in local.flatten_group_access_policies : policy.group => policy }

  flatten_app_access_policies = flatten([for app_access_policy in var.app_access_policies :
    [for a in app_access_policy.apps : {
      app                     = a
      key_permissions         = app_access_policy.key_permissions
      secret_permissions      = app_access_policy.secret_permissions
      certificate_permissions = app_access_policy.certificate_permissions
    }]
  ])

  app_access_policies_map = { for policy in local.flatten_app_access_policies : policy.app => policy }

}