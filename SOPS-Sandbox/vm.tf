module "windowsservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.az01-sops-snbx-rg01
  is_windows_image    = true
  vm_hostname         = "az01_ssbx_sql01" // line can be removed if only one VM module per resource group
  admin_password      = "ComplxP@ssw0rd!"
  vm_os_simple        = "WindowsServer"
  public_ip_dns       = ["winsimplevmips"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.network.vnet_subnets[0]
  boot_diagnostics    = true
  vm_size             = "Standard_D16s_v3"
  depends_on = [azurerm_resource_group.az01-sops-snbx-rg01]
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.az01-sops-snbx-rg01
  subnet_prefixes     = ["172.20.1.0/24"]
  subnet_names        = ["subnet1"]

  depends_on = [azurerm_resource_group.az01-sops-snbx-rg01]
}

output "windows_vm_public_name" {
  value = module.windowsservers.public_ip_dns_name
}
