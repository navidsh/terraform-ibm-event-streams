##############################################################################
# Resource Group
##############################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.6"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# Events-streams-instance
##############################################################################

module "event_streams" {
  source            = "../../"
  resource_group_id = module.resource_group.resource_group_id
  es_name           = "${var.prefix}-es"
  schemas           = var.schemas
  tags              = var.resource_tags
  access_tags       = var.access_tags
  topics            = var.topics
  metrics           = []
  quotas            = []
  service_credential_names = {
    "es_writer" : "Writer",
    "es_reader" : "Reader",
    "es_manager" : "Manager"
  }
}
