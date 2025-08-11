
## For Resource_group
Root_rgs = {
  "rg1" = {
    name = "prod-rg"
    location = "France Central"
    tags = {environment ="prod"}
  }
}

## For VNETS

Root_vnets = {
  "hub-vnet" = {
  virtual_network_name = "Prod-hub-Vnet"
  virtual_network_location ="France Central"
  resource_group_name = "prod-rg"
  address_space =["10.0.0.0/16"]
  dns_servers =["10.0.0.5","10.0.0.6"]
  
}
    
  }

  Root-Subnets = {

    "subnet1" = {
      name = "Hub-subnet"
    address_prefixes =["10.0.0.0/26"]
    virtual_network_name = "Prod-hub-Vnet"
    resource_group_name = "prod-rg"
     location ="France Central"
  }

  
 "VpnGatewaySubnet" ={
    name= "GatewaySubnet"
    address_prefixes  =["10.0.0.64/26"]
    resource_group_name ="prod-rg"
    virtual_network_name = "Prod-hub-Vnet"
    location ="France Central"
  }

  "Firewall" = {
 name = "AzureFirewallSubnet"
 address_prefixes =["10.0.0.192/26"]
resource_group_name ="prod-rg"
virtual_network_name = "Prod-hub-Vnet"
location ="France Central"
  }
"bastionSubnet" = {
  name = "AzureBastionSubnet"
  address_prefixes =["10.0.0.128/26"]
  resource_group_name = "prod-rg"
  virtual_network_name ="Prod-hub-Vnet"
  location ="France Central"
}
  
    }
  
  ## For Storage accounts
  Root-stg = {
    "stg1" = {
      name = "prodstgdevops2027"
      resource_group_name= "prod-rg"
      location= "France Central"
      account_tier = "Standard"
      account_replication_type ="LRS"
    }
    
    "stg2" = {
       name = "devstgdevops202437"
      resource_group_name= "prod-rg"
      location= "France Central"
      account_tier = "Standard"
      account_replication_type ="LRS"

    }
    }
  
   ## For Network Security group
   main-NSGs = {
    
  "nsg1" = {
    name                = "prod-nsg"
    location            = "France Central"
    resource_group_name = "prod-rg"

    security_rule = {
      rule1 = {
        name                       = "RDPAllow"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_port_range     = "3389"
        destination_address_prefix = "*"
      }

      rule2 = {
        name                       = "RDPDeny"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Deny"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_port_range     = "3389"
        destination_address_prefix = "*"
      }
    }
  }
}


## For Public IP
main-pip = {
  "Pip1" = {
    name = "Prod-PublicIp"
    location ="France Central"
    resource_group_name ="prod-rg"
    allocation_method  = "Static"
    
  }
 "Pip2" = {
    name = "dev-PublicIp"
    location ="France Central"
    resource_group_name ="prod-rg"
    allocation_method  = "Static"

  }
  
}

## For NIC (Network Interface Card)
main-NICS = {
  "nic1" = {
    name = "test-nic"
    location = "France Central"
    resource_group_name ="prod-rg"
    subnet_id ="/subscriptions/<sub-id>/resourceGroups/prod-rg/providers/Microsoft.Network/virtualNetworks/Prod-hub-Vnet/subnets/Hub-subnet"
     private_ip_address_allocation = "Dynamic"
    ip_configuration = {
      name = "ipconfig1"
  }
}
}


## For Linux Virtual machine

linux-vm-main = {
  "Vm1" = {
    name = "linux-Vm001"
    resource_group_name ="prod-rg"
    location ="France Central"
    size ="Standard_F2"
    disable_password_authentication = false
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
    admin_username = "linuxuser"
   admin_password = "india@123456789"
   publisher = "canonical"
   offer = "0001-com-ubuntu-server-focal"
  sku =  "20_04-lts"
  version = "latest"
  # NICS = "nic1"
  pip = "Pip1"
  nic_key = "nic1"
  
  }
}

## For keyvaults

keyvaults-main = {
  "Keyvault1" = {
    name = "keyvault202527"
    location= "France Central"
    resource_group_name = "prod-rg"
    tenant_id = "b074efb9-d61f-4817-b0b6-b18188dd2890"
    soft_delete_retention_days = 7
    purge_protection_enabled   = true
    sku_name = "standard"
    access_policy = {

      tenant_id = "b074efb9-d61f-4817-b0b6-b18188dd2890"
      object_id = "7e430a51-a1cb-4cd6-bb1c-ee51548ee1b8" ## to find Object id please use this command az ad signed-in-user show
      key_permissions =["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
      secret_permissions =["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
      storage_permissions =["Get"]
      certificate_permissions =[ "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]

    }
  }
}

## For MSSqlServer 
mssqlserver0007= {

  "mssqlserver22" = {
    name = "mssqlserver2025"
    resource_group_name = "prod-rg"
    location ="France Central" 
    administrator_login = "mssqladmin"
    administrator_login_password ="India@123456789"
    minimum_tls_version  = "1.2"
azuread_administrator = {
login_username = "abhishek@ankitg2051gmail.onmicrosoft.com"
object_id = "7e430a51-a1cb-4cd6-bb1c-ee51548ee1b8"
}
tags ={
  environment = "production"
}

  }
}

### For MSSQL Database
mssqldb2974_main = {
  
  "mssldatbase12" = {
    name = "mssqldatabase29876"
    resource_group_name = "prod-rg"
  sqlserver_name = "mssqlserver2025"
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

  tags = {
    foo = "bar"
  }

  # prevent the possibility of accidental data loss
  lifecycle = {
    prevent_destroy = true
  }
}
}
   
# #  ### For storage Containers

contains-main = {
  
  container1 ={
    name = "devcontainer"
    storage_account_name = "prodstgdevops2027"
    resource_group_name ="prod-rg"
  }

container2 = {
  name = "prodcontainer"
  storage_account_name ="devstgdevops202437"
  resource_group_name = "prod-rg"
}
}

## For Azure Bastions

bastions-main = {
  "bast1" = {
    name = "prodbastion2025"
    location ="France Central" 
    resource_group_name = "prod-rg"
    allocation_method ="Static"
    pip_sku ="Standard"
    virtual_network_name ="Prod-hub-Vnet"
    virtual_network_id = false

  }
}
## For Application Security Group (ASGS)

asgs-main = {
  asg1 ={
    name = "asg-prod"
    location = "France Central" 
    resource_group_name ="prod-rg"
  }
}

### For ACR 
acr_configs-main = {
  "acr1" = {
    name = "prodacr00298763"
    resource_group_name = "prod-rg"
    location ="France Central"
    sku ="Standard"
    admin_enabled =true
    
  }
}

## for MySQL Server

mysqlserver1-main = {

"mysqlserver22" = {
    name = "mysqlserver20256"
    location ="France Central"
    resource_group_name ="prod-rg"
    administrator_login ="mysqladmin"
    administrator_password ="sqlpassword@12345"
    sku_name ="GP_Standard_D2ds_v4"
    version = "8.0.21"
    backup_retention_days = 7
  }
}

### for MYSQL database
mysqldatabase-main = {
  "mysqldatabase123" = {
    name = "accounts"
    charset ="utf8mb4"
    collation ="utf8mb4_general_ci"
    resource_group_name ="prod-rg"
    server_name ="mysqlserver20256"
    
  }
}

## for postgres SQL
postgresql_servers-main = {
  "postgressql2" = {
 location ="France Central"
 resource_group_name ="prod-rg"
 administrator_login ="pgadmin"
    administrator_password = "YourSecureP@ssword1"
    sku_name               = "GP_Standard_D2s_v3"
    version                = "13"
    storage_mb             = 32768
    backup_retention_days = 7
  }
}

## for Cosmos DB Account
cosmos_accounts-main = {
  "account1" = {
    name = "cosmosdb-sql-account1"
    location ="France Central"
    resource_group_name= "prod-rg"
    offer_type = "Standard"
    kind = "GlobalDocumentDB"
    consistency_level = "Session"
    
  }
}
