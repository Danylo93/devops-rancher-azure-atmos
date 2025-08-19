terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.100.0"
    }
  }
}


variable "subscription_id" {}
variable "tenant_id" {}

provider "azurerm" {
  features {}
  subscription_id = "b171271a-b25e-45aa-ad46-f48535580096" # ID da sua subscription
  tenant_id       = "b5306433-1086-417b-83c5-12287dd97f69" # ID do seu tenant
}
