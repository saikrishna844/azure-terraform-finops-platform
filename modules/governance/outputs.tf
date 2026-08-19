output "required_tag_policy_assignment_ids" {
  description = "IDs of required tag Azure Policy assignments"

  value = {
    for tag, assignment in azurerm_resource_group_policy_assignment.required_tags :
    tag => assignment.id
  }
}