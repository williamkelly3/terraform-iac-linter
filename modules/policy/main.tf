resource "azurerm_policy_assignment" "tls_policy" {
  name                 = "enforce-tls12"
  scope                = var.scope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cbcf3bd9-6a1d-4a82-8b6f-28d71e1db9e0"

  display_name     = "Enforce TLS 1.2 or higher"
  description      = "Ensures that only TLS 1.2+ is allowed for Azure resources."
  enforcement_mode = true
}

