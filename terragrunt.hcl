remote_state = {
  backend = "s3"
  config = {
    bucket = "srinath-personal"
    key    = "${path_relative_to_include()}/terraform.tfstate"
    region = "us-east-1"
  }
}
inputs = {
  eks_create_cluster                       = true
  eks_cluster_endpoint_public_access       = true
  eks_cluster_endpoint_public_access_cidrs = ["54.164.230.180/32", "54.218.187.11/32"]
  eks_kubernetes_version                   = "1.21"
  eks_cluster_enable_log_types             = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  eks_cluster_log_retention_in_days        = 30
  region                                   = "us-east-1"
  vpc_cidr                                 = "10.38.4.0/22"
  vpc_private_subnets = ["10.38.4.0/24", "10.38.5.0/24", "10.38.6.0/24"]
  vpc_public_subnets = ["10.38.7.0/27", "10.38.7.32/27", "10.38.7.64/27"]
  vpc_availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=${get_terragrunt_dir()}/values.tfvars",
    ]
  }
}

