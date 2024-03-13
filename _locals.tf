locals {
  redis_family_map = {
    Basic    = "C",
    Standard = "C",
    Premium  = "P"
  }

  data_persistence_enabled = var.sku_name == "Premium" ? var.data_persistence_enabled : false

  default_redis_config = {
    rdb_backup_enabled            = local.data_persistence_enabled
    rdb_storage_connection_string = one(azurerm_storage_account.redis_storage[*].primary_blob_connection_string)
    rdb_backup_frequency          = local.data_persistence_enabled ? var.data_persistence_frequency_in_minutes : null
    rdb_backup_max_snapshot_count = local.data_persistence_enabled ? var.data_persistence_max_snapshot_count : null
  }

  redis_config = merge(local.default_redis_config, var.redis_additional_configuration)

  allowed_cidrs = try(can(tomap(var.allowed_cidrs)) ? tomap(var.allowed_cidrs) : { for x in var.allowed_cidrs : index(var.allowed_cidrs, x) => x }, {})
}

locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  name         = coalesce(var.custom_name, data.azurecaf_name.redis.result)
  storage_name = coalesce(var.data_persistence_storage_custom_name, data.azurecaf_name.data_storage.result)
}

locals {
  default_tags = var.default_tags_enabled ? {
    env   = var.environment
    stack = var.stack
  } : {}
}
