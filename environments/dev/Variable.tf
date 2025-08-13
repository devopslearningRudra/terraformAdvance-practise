# For Resource Group
variable "Root_rgs" {
 description = "A map of resource group to be create"
 type = map(object({
   name = string
   location =string 
    managed_by=optional(string)
   tags =optional(map(string))
   
 }))
}
## For VNET
variable "Root_vnets" {
  description = "A map of Virtual Network to be crate "
  type = map(object({
    virtual_network_name = string 
    address_space = list(string)
    resource_group_name= string
    virtual_network_location = string
    dns_servers = list(string)
    tags = optional(map(string))
  }))

}

## For Subnets
variable "Root-Subnets" {
    description = "A map of subnet to be create"
    type = map(object({
      name = string
      address_prefixes =list(string)
      resource_group_name = string
      virtual_network_name = string
    }))
     
}

## For Storage account

variable "Root-stg"{
  description = "stgs variable is to create multiple storage accounts using for_each"
 type = map(object({
   name = string
   resource_group_name =string
   location =string
   account_replication_type =string
   account_tier =string
   access_tier = optional(string)
   account_kind =optional(string)
   cross_tenant_replication_enabled = optional(bool)
   edge_zone =optional(string)
   https_traffic_only_enabled =optional(bool)
   min_tls_version = optional(string)

 }))

}


## For Network Security Group
variable "main-NSGs" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    security_rules = optional(map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })))
  }))
}

## For Public IP
variable "main-pip" {
  description = "A map of PIP will be created "
    type = map(object({
      name= string
      resource_group_name= string
      location = string
      allocation_method =string
    }))
}

# For Netwrok Interface
variable "main-NICS" {
  description = "A map of NIC will Create"
  type = map(object({
    name = string
    location =string
    resource_group_name =string
    ip_configuration= map(string)
    subnet_id =string
    private_ip_address_allocation= string

  }))
}

## for Linux Virtaul Machine

variable "linux-vm-main" {
    description = "A map of linux VM will create "
    type = map(object({
      name = string
      resource_group_name= string
      location =string
      size =string
      disable_password_authentication =bool
      admin_username =string
      admin_password =string
      caching =string
      storage_account_type =string
      publisher =string
      offer =string
      sku =string
      version =string
     nic_key = string
     pip_key = optional(string)
    }))
}

## for keyVault

variable "keyvaults-main" {
  description = "A map of Keyvaults will be created "
  type = map(object({
    name = string
    location=string
    resource_group_name= string
    tenant_id= string
    sku_name= string
    soft_delete_retention_days =number
    purge_protection_enabled =bool
    access_policy = object({
      tenant_id = string
      object_id = string
      key_permissions = list(string)
      secret_permissions = list(string)
      storage_permissions =list(string)
      certificate_permissions = list(string)
    })
  })) 
}


# ## for MSSql Server

variable "mssqlserver0007" {
    description = "A map of mssqlserver will create"
   type = map(object({
     name = string
     resource_group_name=string
     location =string
     
     administrator_login =string
     administrator_login_password =string
     minimum_tls_version =string
     azuread_administrator = object({
       login_username = string
       object_id =string
     })
     tags =optional (map(string))
   }))
}

## For MSSQL Database

variable "mssqldb2974_main" {

description = "A map of SQLDB will be create"
type = map(object({
  name = string
  resource_group_name =string
  sqlserver_name = string
  sku_name =string
  collation = string
  license_type =string
  max_size_gb = number
  enclave_type = string
lifecycle = object({
   prevent_destroy = bool
 })
 tags = map(string)
}))
  
}

# ## For Storae_Container

variable "contains-main" {
  
}

# For Bastions_host

variable "bastions-main" {
    type = map(object({
      name = string
      location =string
      resource_group_name =string
      pip_sku = string
      virtual_network_name = string
      virtual_network_id = optional(bool)
      shareable_link_enabled = optional(bool)
      scale_units =optional(number)
      kerberos_enabled = optional(bool)
      ip_connect_enabled = optional(bool)
      sku = optional(string)
      allocation_method =string
      copy_paste_enabled = optional(bool)
      file_copy_enabled = optional(bool)
      tags = optional(map(string))
      zones = optional(list(string))
      tunneling_enabled = optional(bool)
      session_recording_enabled = optional(bool)
    }))
}

## For Application Security Group

variable "asgs-main" {
  
}

## For ACR (Azure Container-Registry)
variable "acr_configs-main" {
  description = "A map of ACR Will be create"
  type = map(object({
    resource_group_name =string 
    name =string
    location= string
    sku= string
    admin_enabled = bool
  }))
}
## for MYSQL Server 
variable "mysqlserver1-main" {
   description  = "mySQL Server need to create "
    type = map(object({
      name = string
      location =string
      resource_group_name =string
      administrator_login =string
      administrator_password =string
      sku_name =string
      version =string
      backup_retention_days =number
    }))

}

## For MYSQL Database
variable "mysqldatabase-main" {
  description = "Map of MYSQL database will create"
  type = map(object({
    name = string
    charset = optional(string,"utf8")
    collation =optional(string,"utf8_unicode_ci")
    server_name =string
    resource_group_name =string
  }))
}

## for postgres SQL
variable "postgresql_servers-main" {
  description = "Map of PostgreSQL server configurations"
  type = map(object({
    location          = string
    resource_group_name    = string
    administrator_login = string
    administrator_password = string
    sku_name          = string
    version           = string
    storage_mb        = number
    backup_retention_days = number
  }))
}

## For Cosmos DB Account
variable "cosmos_accounts-main" {
  type = map(object({
    name = string
    location =string
    resource_group_name =string
    offer_type =string
    kind =string
    consistency_level=string
  }))
}
## For Azure Kubernetes Services
variable "aks_clusters-main"{
  description = "Map of AKS cluster definitions"
  type = map(object({
    location       = string
    resource_group = string
    dns_prefix     = string
    node_count     = number
    vm_size        = string
    environment    = string
  }))
}
