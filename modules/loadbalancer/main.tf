resource "azurerm_public_ip" "this" {
  count               = var.is_public ? 1 : 0
  name                = "${var.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_lb" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = var.is_public ? azurerm_public_ip.this[0].id : null
    subnet_id            = var.is_public ? null : var.subnet_id
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "this" {
  name            = "${var.name}-bepool"
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_lb_probe" "this" {
  name            = "tcp-probe"
  loadbalancer_id = azurerm_lb.this.id
  protocol        = "Tcp"
  port            = var.probe_port
}

resource "azurerm_lb_rule" "this" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = "Tcp"
  frontend_port                  = var.frontend_port
  backend_port                   = var.backend_port
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.this.id
}
