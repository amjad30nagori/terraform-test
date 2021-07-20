resource "azurerm_public_ip" "lb-pip" {
  name                = "${var.resource_prefix}-lb-pip"
  resource_group_name = var.resource_group
  location            = var.location
  allocation_method = "Static"
  domain_name_label = var.domain_name_label
}

resource "azurerm_lb" "loadbalancer" {
  name                = "${var.resource_prefix}-vm-lb"
  resource_group_name = var.resource_group
  location            = var.location

  frontend_ip_configuration {
    name                 = "${var.resource_prefix}-lb-frontend-ip"
    public_ip_address_id = azurerm_public_ip.lb-pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  name                = "${var.resource_prefix}-lb-backend"
  loadbalancer_id     = azurerm_lb.loadbalancer.id
}

resource "azurerm_lb_probe" "lb_http_probe" {
  name                = "${var.resource_prefix}-lb-http-probe"
  resource_group_name = var.resource_group
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  protocol            = "tcp"
  port                = "80"
}

resource "azurerm_lb_rule" "lb_http_rule" {

  name                           = "${var.resource_prefix}-lb-http-rule"
  resource_group_name = var.resource_group
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  protocol                       = "tcp"
  frontend_port                  = "80"
  backend_port                   = "80"
  frontend_ip_configuration_name = "${var.resource_prefix}-lb-frontend-ip"
  probe_id                       = azurerm_lb_probe.lb_http_probe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.lb_backend_pool.id
}