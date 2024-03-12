# module "azure_region" {
#   source  = "claranet/regions/azurerm"
#   version = "x.x.x"
#
#   azure_region = var.azure_region
# }
#
# module "rg" {
#   source  = "claranet/rg/azurerm"
#   version = "x.x.x"
#
#   location    = module.azure_region.location
#   client_name = var.client_name
#   environment = var.environment
#   stack       = var.stack
# }
#
# module "logs" {
#   source  = "claranet/run/azurerm//modules/logs"
#   version = "x.x.x"
#
#   client_name         = var.client_name
#   environment         = var.environment
#   stack               = var.stack
#   location            = module.azure_region.location
#   location_short      = module.azure_region.location_short
#   resource_group_name = module.rg.resource_group_name
# }

module "redis" {
  source  = "../../"

  client_name    = var.client_name
  environment    = var.environment
  location       = "centralindia"
  location_short = "centralindia"
  stack          = var.stack

  resource_group_name = "cloud_scrapper"

  allowed_cidrs = ["1.2.3.4/32", "5.6.7.8/16"]

  logs_destinations_ids = [
    "/subscriptions/75223151-1800-43db-a8f3-b7fe605d3385/resourceGroups/cloud_scrapper/providers/Microsoft.Storage/storageAccounts/cloudscappertesting",
    "/subscriptions/75223151-1800-43db-a8f3-b7fe605d3385/resourceGroups/cloud_scrapper/providers/Microsoft.OperationalInsights/workspaces/demo-cloudscapper"
  ]

  extra_tags = {
    foo = "bar"
  }
}
