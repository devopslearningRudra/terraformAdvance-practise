terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.36.0"
    }
  }


  backend "azurerm" {
    use_cli              = true                                    
    use_azuread_auth     = true                                    
    tenant_id            = "b074efb9-d61f-4817-b0b6-b18188dd2890"                                      
    storage_account_name = "genericstg20261" 
    # resource_gresource_group_name = "Prac-RG"                             
    container_name       = "tfstate"                               
    key                  = "prod.terraform.tfstate"                
  }
}


provider "azurerm" {
  features {}
  subscription_id = "8047b6da-5aca-4a1b-a741-1c075ee56791"
}