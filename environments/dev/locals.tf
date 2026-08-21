locals {

  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    Owner       = var.owner
    CostCenter  = var.cost_center
    ManagedBy   = "Terraform"
  }

  ssh_public_key = trimspace(file(pathexpand(var.ssh_public_key_path)))
}
  