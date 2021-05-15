terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name = "terraform-ansible-kubernetes"
  location = "East US"
}

resource "azurerm_resource_group" "tak" {
  name = "my_terraform_CentOS_rg"
  location = "West Europe"
  tags = {
        "environment" = "production"
  }
}

resource "azurerm_virtual_network" "vnetprod019" {
  name                = "vnetprod019"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.tak.location
  resource_group_name = azurerm_resource_group.tak.name
  tags                = {
	"environment" = "production"
  }
}

resource "azurerm_subnet" "subnet019" {
  name                 = "subnet019"
  resource_group_name  = azurerm_resource_group.tak.name
  virtual_network_name = azurerm_virtual_network.vnetprod019.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nicprod019c" {
  name                = "nicprod019c"
  location            = azurerm_resource_group.tak.location
  resource_group_name = azurerm_resource_group.tak.name
  tags                = {
        "environment" = "production"
  }
  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.subnet019.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/ed223ecd-b37b-40f8-91e0-3700864c3759/resourceGroups/my_terraform_CentOS_rg/providers/Microsoft.Network/publicIPAddresses/publicip019c"
  }
}

resource "azurerm_network_interface" "nicprod0192c" {
  name                = "nicprod0192c"
  location            = azurerm_resource_group.tak.location
  resource_group_name = azurerm_resource_group.tak.name
  tags                = {
        "environment" = "production"
  }
  ip_configuration {
    name                          = "myNicConfiguration2"
    subnet_id                     = azurerm_subnet.subnet019.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/ed223ecd-b37b-40f8-91e0-3700864c3759/resourceGroups/my_terraform_CentOS_rg/providers/Microsoft.Network/publicIPAddresses/publicip0192c"
  }
}

resource "azurerm_network_interface" "nicprod0191c" {
  name                = "nicprod0191c"
  location            = azurerm_resource_group.tak.location
  resource_group_name = azurerm_resource_group.tak.name
  tags                = {
        "environment" = "production"
  }
  ip_configuration {
    name                          = "myNicConfiguration1"
    subnet_id                     = azurerm_subnet.subnet019.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/ed223ecd-b37b-40f8-91e0-3700864c3759/resourceGroups/my_terraform_CentOS_rg/providers/Microsoft.Network/publicIPAddresses/publicip0191c"
  }
}
# Your Terraform code goes here...