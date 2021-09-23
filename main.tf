 terraform {
 required_version = "= 1.0.7" 
 backend "azurerm" {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
  storage_account_name = ""
  container_name       = ""
  key                  = ""
	access_key  = ""
    features{}
	}
}

data "azurerm_client_config" "current" {}

provider "azurerm" {
features {}

}
resource "azurerm_resource_group" "rglog" {
  name     = var.rg
  location = var.location
}

#lukas 
resource "azurerm_app_service_plan" "appservice" {
  name                = var.appservice
  location            = azurerm_resource_group.rglog.location
  resource_group_name = azurerm_resource_group.rglog.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "webapp" {
  name                = var.appservicewebapp
  location            = azurerm_resource_group.rglog.location
  resource_group_name = azurerm_resource_group.rglog.name
  app_service_plan_id = azurerm_app_service_plan.appservice.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-valuenewval1ue"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}


resource "azurerm_storage_account" "storage" {
  name                     = var.stoname
  resource_group_name      = azurerm_resource_group.rglog.name
  location                 = azurerm_resource_group.rglog.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}



module "storage2" {
  source              = ".//modules/storage2"
  name                = var.name2
  resource_group_name = azurerm_resource_group.rglog.name
  location            = azurerm_resource_group.rglog.location
}