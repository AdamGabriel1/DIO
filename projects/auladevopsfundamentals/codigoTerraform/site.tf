# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0" # Optional but recommended in production
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
# Create Resource Group 
resource "azurerm_resource_group" "rg" {
  location = "westeurope"
  name     = "rg-auladevops-002"
  tags = merge(var.tags, {
    "workspace" = "${terraform.workspace}"
    }
  )
}

resource "azurerm_storage_account" "site" {
  name                      = "staccdevopsrg21605"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true

  static_website {
    index_document = "index.html"
  }

  tags = merge(var.tags, {
    "workspace" = "${terraform.workspace}"
    }
  )
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-devops-002"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-devops-002"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Public IP Address
resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip-devops-002"
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "nic-devops-002"
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig-devops-002"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# Virtual Machine
resource "azurerm_virtual_machine" "vm" {
  name                  = "vm-devops-002"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-devops-002"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "adminuser"
    admin_password = "Password1234!" # You should use secrets or SSH keys in production
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# SQL Database
resource "azurerm_sql_server" "sql" {
  name                         = "sql-devops-002"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Password1234!" # You should use secrets in production
}

resource "azurerm_sql_database" "sqldb" {
  name                = "sqldb-devops-002"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.sql.name
  edition             = "Standard"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 1
}

# Azure Functions
resource "azurerm_function_app" "function_app" {
  name                      = "funcapp-devops-002"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  app_service_plan_id       = azurerm_app_service_plan.app_service_plan.id
  storage_account_name      = azurerm_storage_account.site.name
  version                   = "~3"
  enable_builtin_logging    = true
}

# App Service Plan
resource "azurerm_app_service_plan" "app_service_plan" {
  name                    = "appserviceplan-devops-002"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  sku_tier                = "Standard"
  sku_size                = "S1"
}

# Blob Storage
resource "azurerm_storage_container" "blob_container" {
  name                  = "blobcontainerdevops002"
  storage_account_name  = azurerm_storage_account.site.name
  container_access_type = "private"
}

module "network" {
  source              = "./modules/network"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "virtual_machine" {
  source              = "./modules/virtual_machine"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "database" {
  source              = "./modules/database"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

