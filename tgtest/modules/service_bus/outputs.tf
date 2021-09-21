
output "namespace_id" {
  value = azurerm_servicebus_namespace.sb.id
}

output "namespace_name" {
  value = azurerm_servicebus_namespace.sb.name
}

output "queue_ids" {
  value = { for key, value in azurerm_servicebus_queue.sbq : key => value.id }
}

output "queue_connection_strings" {
  value = { for key, value in azurerm_servicebus_queue_authorization_rule.sqa :
    key => replace(value.primary_connection_string, "/;EntityPath.*/", "")
  }
}

output "topic_ids" {
  value = { for key, value in azurerm_servicebus_topic.sbt : key => value.id }
}

output "topic_connection_strings" {
  value = { for key, value in azurerm_servicebus_topic_authorization_rule.sta : key => value.primary_connection_string }
}
