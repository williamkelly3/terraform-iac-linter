output "lb_id" {
  description = "The ID of the load balancer"
  value       = azurerm_lb.this.id
}

output "backend_pool_id" {
  description = "The ID of the backend address pool"
  value       = azurerm_lb_backend_address_pool.this.id
}

output "frontend_ip_config_name" {
  description = "The frontend IP config name (for VMSS association)"
  value       = "LoadBalancerFrontEnd"
}

output "probe_id" {
  description = "The health probe ID"
  value       = azurerm_lb_probe.this.id
}
