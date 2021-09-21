
locals {

  queues = {
    for key, value in var.queues :
    key => merge({
      name                       = ""
      auto_delete_on_idle        = null
      default_message_ttl        = null
      enable_express             = false
      enable_partitioning        = false
      lock_duration              = null
      max_size                   = null
      enable_duplicate_detection = false
      enable_session             = false
      max_delivery_count         = 10
      authorization_rules        = []

      enable_dead_lettering_on_message_expiration = false
      duplicate_detection_history_time_window     = null
    }, value)
  }

  topics = {
    for key, value in var.topics :
    key => merge({
      name                       = ""
      status                     = "Active"
      auto_delete_on_idle        = null
      default_message_ttl        = null
      enable_batched_operations  = null
      enable_express             = null
      enable_partitioning        = null
      max_size                   = null
      enable_duplicate_detection = null
      enable_ordering            = null
      authorization_rules        = []
      subscriptions              = []

      duplicate_detection_history_time_window = null
    }, value)
  }

}
