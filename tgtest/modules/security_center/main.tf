/**
 * # Module: Security Center
 *
 * Setup configuration for Security Center
 *
 * ## Usage
 *
 * This section explains in more detail the input maps and the expected keys within.
 *
 * ### With Terragrunt
 *
 * A complete example to create one vm is as follows, from a Terragrunt deployment point-of-view.
 * Majority of resources are related each other.
 *
 * If these resources are part of the same Terragrunt deployment we reference them by using their keys.
 * Else when the resources are defined separately we can resolve those dependencies with Terragrunt by
 * using "dependency" blocks and then pass the corresponding fiels (normally id's).
 *
 * ```js
 * inputs = {
 *   ...
 *   security_center_automation = {
 *     sources = {
 *       s1 = {
 *         event_source = "xx"
 *         rule_set = {
 *           r1 = { ... }
 *         }
 *       }
 *     }
 *     actions = {
 *       a1 = {
 *         type              = "EventHub"
 *         resource_id       = xx
 *         connection_string = xx
 *       }
 *     }
 *   }
 *
 *   ...
 * }
 * ```
 */

terraform {
  required_version = ">= 0.13.0"
  required_providers {
    azurerm = ">= 2.15.0"
  }
}


resource "azurerm_security_center_automation" "sca" {
  count = try(var.automation, {}) != {} ? 1 : 0

  # this value is forced so that config appears on the portal
  name = "exportToEventHub"

  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "source" {
    for_each = try(var.automation.sources, {})

    content {
      event_source = source.value.event_source

      dynamic "rule_set" {
        for_each = try(source.value.rule_set, {}) != {} ? [1] : []

        content {
          dynamic "rule" {
            for_each = try(source.value.rule_set, {})

            content {
              property_path  = rule.value.property_path
              operator       = rule.value.operator
              expected_value = rule.value.expected_value
              property_type  = rule.value.property_type
            }
          }
        }
      }
    }
  }

  dynamic "action" {
    for_each = try(var.automation.actions, {})

    content {
      type              = "EventHub"
      resource_id       = action.value.resource_id
      connection_string = action.value.connection_string
    }
  }

  scopes = [data.azurerm_subscription.current.id]
}
