resource "azurerm_resource_group" "abhishekdemo" {
    name = "abhi001"
    location = "Central India"

tags = {
    Environment = "Dev"
    Owner = "Abhishek"
}
}

#Now we creating Storage account
resource "azurerm_storage_account" "abhistordemo" {
    name = "abhistoragedemo01"
    resource_group_name = azurerm_resource_group.abhishekdemo.name
    location = azurerm_resource_group.abhishekdemo.location
    account_tier = "Standard"
    account_replication_type = "LRS"

}

#Now we creating container
resource "azurerm_storage_container" "abhishekcontainerdemo" {
    name = "containerdemo001"
    storage_account_id = azurerm_storage_account.abhistordemo
    container_access_type = "private"
}
