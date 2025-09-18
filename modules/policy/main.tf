resource "azapi_resource" "tls_policy" {
  type      = "Microsoft.Authorization/policyAssignments@2021-06-01"
  name      = "enforce-tls12"
  parent_id = var.scope

  body = jsonencode({
    properties = {
      displayName  = "Enforce TLS 1.2 or higher"
      description  = "Ensures that only TLS 1.2+ is allowed for Azure resources."
      policyDefinitionId = "/providers/Microsoft.Authorization/policyDefinitions/cbcf3bd9-6a1d-4a82-8b6f-28d71e1db9e0"
      enforcementMode    = "Default"
    }
  })
}
