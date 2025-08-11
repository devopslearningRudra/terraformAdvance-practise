module "module-rg" {
source = "../../modules/azurerm-rgs"
main_rgs = var.Root_rgs
}

module "module-vnet" {
    depends_on = [ module.module-rg ]
    source = "../../modules/azurerm-VNETS"
  main_vnets = var.Root_vnets

}

module "module-Subnets" {
  depends_on = [ module.module-vnet ]
  source = "../../modules/azurerm-subnets"
  main-subnets = var.Root-Subnets

}

module "module-stg" {
  depends_on = [ module.module-rg ]
  source = "../../modules/azurerm-Stgs"
  main-stg = var.Root-stg
}

module "modules-nsg" {
  depends_on = [ module.module-rg ]
  source = "../../modules/azurerm-nsgs"
  NSGs = var.main-NSGs

}

module "Public_IP" {
  depends_on = [ module.module-rg ]
  source = "../../modules/azurerm-public-ip"
 PIP = var.main-pip
}

module "network_interface" {
  depends_on = [ module.module-Subnets ]
  source = "../../modules/azurerm-Network-Interface"
  NICS = var.main-NICS
}

module "linux-vm"{
depends_on = [module.module-vnet,module.module-Subnets,module.network_interface ]
source = "../../modules/azurerm-linux-vms"
linux-vm =var.linux-vm-main
NICS = var.main-NICS
PIP = var.main-pip
}

module "keyvault-module" {
  depends_on = [ module.module-rg ]
  source = "../../modules/azurerm-keyvault"
  keyvaults = var.keyvaults-main 
}

module "sqlserver-module" {
  depends_on = [ module.module-rg ]
  source = "../../modules/azurerm_sql_server"
  mssqlserver289 = var.mssqlserver0007
}

module "msssqldatabase-module" {

depends_on = [ module.sqlserver-module ]
source = "../../modules/azurerm-sql-databases"
mssqldb2928_demo = var.mssqldb2974_main
  
}

module "Storage_container_module" {
  depends_on = [ module.module-stg,module.module-rg ]
  source = "../../modules/azurerm-container"
  contains = var.contains-main
}

module "Bastion-module" {
  depends_on = [ module.module-Subnets,module.module-vnet ]
  source = "../../modules/azurerm-bastions"
  bastions = var.bastions-main
  
}

module "asgs-module" {
  depends_on = [ module.module-rg ]
  source = "../../modules/azurerm-asgs"
  asgs = var.asgs-main
}

module "acr-module" {
  depends_on = [ module.module-rg ]
  source = "../../modules/azurerm-ACR"
  acr_configs = var.acr_configs-main
  
}

module "mysqlserver-module" {
source = "../../modules/MySQL_server"
mysqlserver1 = var.mysqlserver1-main
}

module "mysqldatabase-module" {
  depends_on = [ module.mysqlserver-module ]
  source = "../../modules/MYSQL_DB"
  mysqldatabase = var.mysqldatabase-main
}

module "cosmos-account-module" {
  source = "../../modules/azurerm-Cosmos_DB"
  cosmos_accounts = var.cosmos_accounts-main
  
}