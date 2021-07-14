terraform {
backend "remote" {
    hostname = "app.terraform.io"
    organization = "Avanti"

    workspaces {
      name = "00_sops_group"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {
}
