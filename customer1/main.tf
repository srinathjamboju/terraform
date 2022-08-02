terraform {
  required_version = "~> v1.2.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.72.0"
    }
  }
}
locals {
  eks_tags = {
    CreatedBy = "ci_de_sre_role"
  }
  common_tags = {
    owner          = "sre-cog"
    terraform      = true
    aws_region     = var.region
    cloud_provider = "aws"
    cloud_region   = "us_east_1"
  }
  finops_tags = {
    segment        = var.segment
    product_family = var.product_family
    product        = var.product
    tier           = var.tier
    feature        = var.feature
    service_region = var.service_region
    customer       = var.customer
    foundation     = join("-", [local.common_tags.cloud_provider, local.common_tags.cloud_region])
    entity         = join("-", [var.customer, var.service_region])
    namespace      = join("-", [var.product, var.tier])
    environment    = join("-", [var.customer, var.service_region, var.product, var.tier])
  }
  cluster_name = {
    eks_cluster_name = join("-", ["cog", local.finops_tags.customer, local.finops_tags.tier, local.common_tags.aws_region, "1"])
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v3.11.3"

  azs                          = var.vpc_availability_zones
  cidr                         = var.vpc_cidr
  create_database_subnet_group = var.vpc_create_database_subnet_group
  create_vpc                   = var.vpc_create
  enable_dns_hostnames         = var.vpc_enable_dns_hostnames
  enable_nat_gateway           = var.vpc_enable_nat_gateway
  enable_vpn_gateway           = var.vpc_enable_vpn_gateway
  name                         = local.cluster_name.eks_cluster_name
  private_subnet_tags          = merge(var.vpc_private_subnet_tags, { "kubernetes.io/cluster/${local.cluster_name.eks_cluster_name}" = "shared" })
  private_subnets              = var.vpc_private_subnets
  public_subnet_tags           = merge(var.vpc_public_subnet_tags, { "kubernetes.io/cluster/${local.cluster_name.eks_cluster_name}" = "shared" })
  public_subnets               = var.vpc_public_subnets
  tags                         = merge(local.common_tags, local.finops_tags)
}

module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "v18.2.0"

  cluster_enabled_log_types              = var.eks_cluster_enable_log_types
  cluster_endpoint_private_access        = var.eks_cluster_endpoint_private_access
  cluster_endpoint_public_access         = var.eks_cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs   = var.eks_cluster_endpoint_public_access_cidrs
  cloudwatch_log_group_retention_in_days = var.eks_cluster_log_retention_in_days
  cluster_name                           = join("-", ["cog", local.finops_tags.customer, local.finops_tags.tier, local.common_tags.aws_region, "1"])
  cluster_version                        = var.eks_kubernetes_version
  create                                 = var.eks_create_cluster
  enable_irsa                            = var.eks_enable_irsa
  eks_managed_node_groups                = var.eks_cluster_node_groups
  eks_managed_node_group_defaults        = var.eks_cluster_node_groups_defaults
  subnet_ids                             = module.vpc.private_subnets
  tags                                   = merge(local.eks_tags, local.common_tags, local.finops_tags)
  vpc_id                                 = module.vpc.vpc_id
  cluster_security_group_additional_rules = {
    ingress_allow_all_from_node_sg = {
      description                = "Node groups to all port/protocols in cluster"
      protocol                   = "all"
      from_port                  = 0
      to_port                    = 0
      type                       = "ingress"
      source_node_security_group = true
    }
  }
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "all"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description = "Node Internet all ports/protocols"
      protocol    = "all"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks        = ["0.0.0.0/0"]
    }
    ingress_allow_all_from_cluster_sg = {
      description                   = "Worker nodes to all ports/protocols in control plane"
      protocol                      = "all"
      from_port                     = 0
      to_port                       = 0
      type                          = "ingress"
      source_cluster_security_group = true
    }
  }
}