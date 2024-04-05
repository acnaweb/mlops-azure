provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "mlops" {
  name     = "resource-group-mlops"
  location = "East US"
}

resource "azurerm_container_registry" "pycaret3" {
  name                  = "marketminingpycaret3"
  resource_group_name   = azurerm_resource_group.mlops.name
  location              = azurerm_resource_group.mlops.location
  sku                   = "Basic"
  data_endpoint_enabled = false
}

data "azurerm_container_registry_scope_map" "repositories_admin" {
  name                    = "_repositories_admin"
  resource_group_name     = azurerm_resource_group.mlops.name
  container_registry_name = azurerm_container_registry.pycaret3.name
}

resource "azurerm_container_registry_token" "mlops_token" {
  name                    = "mlops_token"
  container_registry_name = azurerm_container_registry.pycaret3.name
  resource_group_name     = azurerm_container_registry.pycaret3.resource_group_name
  scope_map_id            = data.azurerm_container_registry_scope_map.repositories_admin.id
  
}
