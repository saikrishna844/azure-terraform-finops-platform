locals {
  require_tag_policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
}

resource "azurerm_resource_group_policy_assignment" "required_tags" {
  for_each = var.required_tags

  name                 = "req-${lower(each.value)}"
  resource_group_id    = var.resource_group_id
  policy_definition_id = local.require_tag_policy_definition_id

  display_name = "Require ${each.value} tag"

  description = "Requires Azure resources to include the ${each.value} tag."

  enforce = var.enforce_policy

  parameters = jsonencode({
    tagName = {
      value = each.value
    }
  })

  non_compliance_message {
    content = "Resource must include the '${each.value}' tag."
  }
}