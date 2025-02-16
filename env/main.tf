terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.80.0"
    }
  }
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

locals {
  rgname = azurerm_resource_group.rgname.name
  rglocation = azurerm_resource_group.rgname.location
  /*dbid = azurerm_mssql_server.sqlserver.id*/
}

resource "azurerm_resource_group" "rgname" {
    name = var.rg_name
    location = var.rg_location  
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = local.rgname
  location            = local.rglocation
  sku                 = "Standard"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "akscluster" {
  name                = var.aks_name
  location            = local.rglocation
  resource_group_name = local.rgname
  dns_prefix          = "akstest"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
    dns_service_ip = "10.0.0.10"
    service_cidr = "10.0.0.0/16"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "aks2acr" {
  principal_id                     = azurerm_kubernetes_cluster.akscluster.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

/*resource "azurerm_mssql_server" "sqlserver" {
  name                = "__SQLServer__"
  resource_group_name = local.rgname
  location            = "West US"
  version             = "12.0"
  administrator_login          = "__SQLUSER__"
  administrator_login_password = "__SQLPass__"
}*/


data "azurerm_mssql_server" "sqlserver" {
  name                = "abbserver56"
  resource_group_name = "abbAKSRG"
}

output "id" {
  value = data.azurerm_mssql_server.sqlserver.id
}
resource "azurerm_mssql_database" "sqldb" {
  name                = "__DatabaseName__"
  server_id           = data.azurerm_mssql_server.sqlserver.id
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 1
  sku_name            = "Basic"
}