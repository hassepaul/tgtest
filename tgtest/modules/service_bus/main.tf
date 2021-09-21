
# Naming convention
module "naming" {
  source = "../naming"
  suffix = var.suffix
}

# Deploy Service Bus
resource "azurerm_servicebus_namespace" "sb" {
  name                = module.naming.servicebus_namespace.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  capacity            = var.capacity
  zone_redundant      = var.zone_redundant
  tags                = var.tags
}

# Deploy Private Endpoint (optional)
resource "azurerm_private_endpoint" "pe" {
  count               = var.subnet_id != null ? 1 : 0
  name                = "pe-${azurerm_servicebus_namespace.sb.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id

  dynamic "private_dns_zone_group" {
    for_each = length(var.private_dns_zone_ids) != 0 ? [1] : []

    content {
      name                 = "pdnszg-${azurerm_servicebus_namespace.sb.name}"
      private_dns_zone_ids = var.private_dns_zone_ids
    }
  }

  private_service_connection {
    name                           = module.naming.private_service_connection.name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_servicebus_namespace.sb.id
    subresource_names              = ["namespace"]
  }

}

# Deploy queues
resource "azurerm_servicebus_queue" "sbq" {
  for_each = try(local.queues, {})

  namespace_name                          = azurerm_servicebus_namespace.sb.name
  resource_group_name                     = var.resource_group_name
  name                                    = each.value.name
  auto_delete_on_idle                     = each.value.auto_delete_on_idle
  default_message_ttl                     = each.value.default_message_ttl
  enable_express                          = each.value.enable_express
  enable_partitioning                     = each.value.enable_partitioning
  lock_duration                           = each.value.lock_duration
  max_size_in_megabytes                   = each.value.max_size
  requires_duplicate_detection            = each.value.enable_duplicate_detection
  requires_session                        = each.value.enable_session
  dead_lettering_on_message_expiration    = each.value.enable_dead_lettering_on_message_expiration
  max_delivery_count                      = each.value.max_delivery_count
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
}

# Deploy queues' SAS policies
resource "azurerm_servicebus_queue_authorization_rule" "sqa" {
  for_each = try(var.queue_auth_rules, {})

  name                = each.value.name
  namespace_name      = azurerm_servicebus_namespace.sb.name
  queue_name          = azurerm_servicebus_queue.sbq[each.value.queue_key].name
  resource_group_name = var.resource_group_name

  listen = try(each.value.listen, false)
  send   = try(each.value.send, false)
  manage = try(each.value.manage, false)
}

# Deploy topics
resource "azurerm_servicebus_topic" "sbt" {
  for_each = try(local.topics, {})

  namespace_name                          = azurerm_servicebus_namespace.sb.name
  resource_group_name                     = var.resource_group_name
  name                                    = each.value.name
  status                                  = each.value.status
  auto_delete_on_idle                     = each.value.auto_delete_on_idle
  default_message_ttl                     = each.value.default_message_ttl
  enable_batched_operations               = each.value.enable_batched_operations
  enable_express                          = each.value.enable_express
  enable_partitioning                     = each.value.enable_partitioning
  max_size_in_megabytes                   = each.value.max_size
  requires_duplicate_detection            = each.value.enable_duplicate_detection
  support_ordering                        = each.value.enable_ordering
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
}

# Deploy topics' SAS policies
resource "azurerm_servicebus_topic_authorization_rule" "sta" {
  for_each = try(var.topic_auth_rules, {})

  name                = each.value.name
  namespace_name      = azurerm_servicebus_namespace.sb.name
  topic_name          = azurerm_servicebus_topic.sbt[each.value.topic_key].name
  resource_group_name = var.resource_group_name

  listen = try(each.value.listen, false)
  send   = try(each.value.send, false)
  manage = try(each.value.manage, false)
}
