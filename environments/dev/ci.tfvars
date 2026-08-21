location = "centralindia"

environment = "dev"

project_name = "terraform-finops"

owner = "SaiKrishna"

cost_center = "CC-1001"


# Networking

vnet_address_space = [
  "10.10.0.0/16"
]

app_subnet_prefixes = [
  "10.10.1.0/24"
]

management_subnet_prefixes = [
  "10.10.2.0/24"
]


# Compute

vm_size = "Standard_D4s_v5"

admin_username = "azureadmin"

ssh_public_key_path = "/home/runner/.ssh/finops_vm.pub"


# Monitoring

cpu_alert_threshold = 80
service_name        = "azure-finops-platform"

# Governance

required_tags = [
  "Environment",
  "Project",
  "Owner",
  "CostCenter",
  "ManagedBy",
  "Service"
]
enforce_tag_policy = true