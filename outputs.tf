output "vm_name" {
  value = azurerm_windows_virtual_machine.abhifirstvm.name
}
output "vm_id" {
  value = azurerm_windows_virtual_machine.abhifirstvm.id
}
output "public_ip_id" {
  value = azurerm_public_ip.abhipip001.id
}
