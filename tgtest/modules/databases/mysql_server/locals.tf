
locals {
  mysql_config = merge({
    log_bin_trust_function_creators        = "ON"
    long_query_time                        = "0.5"
    query_store_capture_mode               = "ALL"
    query_store_wait_sampling_capture_mode = "ALL"
    slow_query_log                         = "ON"
    sql_mode                               = "STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
  }, var.mysql_config)
}
