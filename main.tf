resource "azurerm_resource_group" "abhishekdemo" {
  name     = "abhi001"
  location = "Central India"

  tags = {
    Environment = "Dev"
    Owner       = "Abhishek"
  }
}

#Now we creating Storage account
resource "azurerm_storage_account" "abhistordemo" {
  name                     = "abhistoragedemo01"
  resource_group_name      = azurerm_resource_group.abhishekdemo.name
  location                 = azurerm_resource_group.abhishekdemo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

#Now we creating container
resource "azurerm_storage_container" "abhishekcontainerdemo" {
  name                  = "containerdemo001"
  storage_account_id    = azurerm_storage_account.abhistordemo.id
  container_access_type = "private"
}

#Now we creating vnet
resource "azurerm_virtual_network" "abhivnet" {
  name                = "abhivnet001"
  resource_group_name = azurerm_resource_group.abhishekdemo.name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.abhishekdemo.location
}

#now We creating subnet
resource "azurerm_subnet" "abhisubnet" {
  name                 = "abhisubnet001"
  resource_group_name  = azurerm_resource_group.abhishekdemo.name
  virtual_network_name = azurerm_virtual_network.abhivnet.name
  address_prefixes     = ["10.0.1.0/24"]

}
#now we creating NSG
resource "azurerm_network_security_group" "abhinsg001" {
  name                = "abhinsg000"
  resource_group_name = azurerm_resource_group.abhishekdemo.name
  location            = azurerm_resource_group.abhishekdemo.location

  security_rule {
    name                       = "AllowRDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


}

#NOW Creating NSG Association

resource "azurerm_subnet_network_security_group_association" "nsgasssocition" {
  subnet_id                 = azurerm_subnet.abhisubnet.id
  network_security_group_id = azurerm_network_security_group.abhinsg001.id

}
