locals {
  env         = var.environment
  name        = var.client_name
  name_prefix = "${local.env}${local.name}"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.name_prefix}rg"
  location = var.location
  tags     = var.extra_tags
}

module "log_analytics" {
  source = "git::https://github.com/tothenew/terraform-azure-loganalytics.git"
#  source = "../.."

  workspace_name          = "${local.name_prefix}-log"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  diagnostic_setting_name = "${local.name_prefix}-log-diagnostic-setting"
}

#module "log_analytics" {
#  source = "git::https://github.com/tothenew/terraform-azure-loganalytics.git"
#
#  workspace_name      = "${local.name_prefix}-log"
#  resource_group_name = azurerm_resource_group.rg.name
#  location            = azurerm_resource_group.rg.location
#  tags = var.extra_tags
#}

module "redis" {
  source  = "../../"

  client_name    = var.client_name
  environment    = var.environment
  location       = var.location
  location_short = var.location
  stack          = var.stack
  sku_name       = var.sku_name

  resource_group_name = azurerm_resource_group.rg.name

  allowed_cidrs = ["1.2.3.4/32", "5.6.7.8/16"]

  logs_destinations_ids = [
    module.log_analytics.workspace_id
  ]

  extra_tags = var.extra_tags
}
