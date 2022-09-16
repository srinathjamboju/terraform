variable "segment" {
  description = "Delineation which market segment the service falls under.Preferred to use default only."
  type        = string
  default     = "enterprise"
  validation {
    condition     = contains(["enterprise", "professional", "corporate", "government"], var.segment)
    error_message = "Valid values for variable segment are: (enterprise, professional, corporate, government)."
  }
}

variable "product_family" {
  description = "Within a market segment, the general product family that the resource is serving."
  type        = string
  default     = "aws"
  validation {
    condition     = contains(["aws"], var.product_family)
    error_message = "Valid values for variable product_family are: (aws)."
  }
}

variable "product" {
  description = "Within a product family, the specific product that the resource is serving."
  type        = string
  default     = "learning"
  validation {
    condition     = contains(["learning"], var.product)
    error_message = "Valid values for variable product are: (learning)."
  }
}

variable "tier" {
  description = "Environment scope of the deployment and resources. Path to prod: dev -> test -> perf(optional) -> uat|preview|stage ->production"
  type        = string
  default     = "poc"
  validation {
    condition     = contains(["dev", "test", "perf", "demo", "sandbox", "poc", "preview", "uat", "stage", "production"], var.tier)
    error_message = "Valid values for variable tier are: (dev, test, perf, demo, sandbox, poc, preview, uat, stage, production)."
  }
}

variable "service_region" {
  description = "Global region for the service. In well known regions, use common industry abbreviations, otherwise for country specific regions use the ISO 3166 two letter ISO code."
  type        = string
  default     = "nam"
  validation {
    condition     = contains(["apac", "emea", "latm", "nam"], var.service_region)
    error_message = "Valid values for variable service_region are: (apac, emea, latm, nam)."
  }
}

variable "feature" {
  description = "Within a product, the feature that the resource is serving."
  type        = string
  default     = "terraform"
  validation {
    condition     = contains(["terraform"], var.feature)
    error_message = "Valid values for variable service_region are: (terraform)."
  }
}

variable "customer" {
  description = "Name of the customer the resource is providing services for. For multicustomer resources where a resource is being used by multiple deployments in a foundation, use platform. Otherwise for resources that are being use internally in test, use internal."
  type        = string
  default     = "test"
  validation {
    condition     = contains(["test"], var.customer)
    error_message = "Valid values for variable customer are: (test)."
  }
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC."
  type        = string
}

variable "vpc_availability_zones" {
  description = "A list of availability zones names or ids in the region."
  type        = list(string)
}

variable "vpc_private_subnets" {
  default     = []
  description = "A list of VPC's private subnets to be created."
  type        = list(string)
}

variable "vpc_public_subnets" {
  default     = []
  description = "A list of VPC's public subnets to be created."
  type        = list(string)
}

variable "vpc_enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks."
  type        = bool
  default     = true
}

variable "vpc_enable_vpn_gateway" {
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC."
  type        = bool
  default     = false
}

variable "vpc_enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable "vpc_enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "vpc_private_subnet_tags" {
  description = "Tags to be added to the private subnets."
  type        = map(string)
  default = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}

variable "vpc_public_subnet_tags" {
  description = "Tags to be added to the private subnets."
  type        = map(string)
  default = {
    "kubernetes.io/role/elb" = "1"
  }
}

variable "vpc_create" {
  default     = true
  description = "Whether or not to create the VPC"
  type        = bool
}

variable "vpc_create_database_subnet_group" {
  description = "Controls if database subnet group should be created."
  type        = bool
  default     = false
}
variable "eks_create_cluster" {
  description = "Whether to create the EKS cluster."
  type        = bool
  default     = true
}

variable "eks_cluster_endpoint_private_access" {
  description = " Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = true
}

variable "eks_cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  default     = false
}

variable "eks_cluster_endpoint_public_access_cidrs" {
  description = "CIDR of the addresses that will be allowed in the SG to contact the cluster public endpoint."
  type        = list(string)
}

variable "eks_cluster_enable_log_types" {
  description = "A list of the desired control plane logging to enable."
  type        = list(string)
}

variable "eks_cluster_log_retention_in_days" {
  description = "Number of days to retain log events."
  type        = number
}

variable "eks_enable_irsa" {
  description = "Whether to create OpenID Connect Provider for EKS to enable IRSA."
  type        = bool
  default     = true
}

variable "eks_kubernetes_version" {
  description = "Kubernetes version to use in the control planes of the EKS cluster."
  type        = string
}

variable "eks_manage_aws_auth" {
  description = "Whether to apply the aws-auth configmap file."
  type        = bool
  default     = false
}

variable "eks_write_kubeconfig" {
  description = "Whether to write a Kubectl config file containing the cluster configuration. Saved to `kubeconfig_output_path`."
  type        = bool
  default     = false
}

variable "eks_cluster_node_groups_defaults" {
  description = "Map of values to be applied to all node groups."
  type        = any
}

variable "eks_cluster_node_groups" {
  description = "Map of map of node groups to create."
  type        = any
}

variable "eks_cluster_vpc" {
  default     = ""
  description = "The VPC to be used for creating the cluster in"
  type        = string
}

variable "eks_subnets" {
  default     = []
  description = "The subnets where the cluster and workers will be place in"
  type        = list(string)
}

variable "cognition_buckets" {
  description = "Map containing key/value pairs being the 'key' the kind of bucket and the 'value' the name of the bucket"
  type        = map(any)
  default     = {}
}

variable "cert_manager_iam_role_name" {
  description = "The name to be used for the Cert Manager IAM role."
  default     = "EKSCertManager"
  type        = string
}
variable "cert_manager_iam_policy_name" {
  description = "The name to be used for the AWS Load Balancer Controller IAM policy."
  default     = "AllowCertManagerToModifyRoute53Records"
  type        = string
}
variable "iam_roles_name_prefix" {
  description = "Prefix to be used on all IAM roles created by this module."
  default     = "Role"
  type        = string
}

variable "iam_policies_name_prefix" {
  description = "Prefix to be used on all IAM policies created by this module."
  default     = "Policy"
  type        = string
}

variable "cluster_autoscaler_iam_role_name" {
  description = "The name to be used for the Cluster Autoscaler IAM role."
  default     = "ClusterAutoscaler"
  type        = string
}

variable "cluster_autoscaler_iam_policy_name" {
  description = "The name to be used for the Cluster Autoscaler IAM policy."
  default     = "ClusterAutoscaler"
  type        = string
}

variable "aws_load_balancer_controller_iam_role_name" {
  description = "The name to be used for the AWS Load Balancer Controller IAM role."
  default     = "ELBController"
  type        = string
}

variable "aws_load_balancer_controller_iam_policy_name" {
  description = "The name to be used for the AWS Load Balancer Controller IAM policy."
  default     = "ELBController"
  type        = string
}

variable "external_dns_iam_role_name" {
  description = "The name to be used for the External DNS IAM role."
  default     = "ExternalDNS"
  type        = string
}

variable "external_dns_iam_policy_name" {
  description = "The name to be used for the External DNS IAM policy."
  default     = "ExternalDNS"
  type        = string
}

variable "region" {
  description = "AWS Region, e.g us-west-2"
}

variable "eks_iam_policy_name" {
  description = "The name to be used for the EKS IAM policy."
  default     = "EKS"
  type        = string
}

variable "vault_endpoint_service_name" {
  description = "Service name of Vault endpoint service"
  type        = string
}

variable "cognition_iam_username" {
  default     = "cognition.app"
  description = "The name of the IAM user to be created"
  type        = string
}

variable "enable_server_side_encryption_configuration" {
  description = "Whether to enable default server side encryption."
  type        = bool
  default     = true
}

variable "server_side_encryption_configuration" {
  description = "Server-side encryption configuration."
  type = object({ rule = object({
    bucket_key_enabled                      = string
    apply_server_side_encryption_by_default = map(string)
  })
  })
  default = {
    rule = {
      bucket_key_enabled = null
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}

variable "logging_configuration" {
  type = map(string)
  default = {
    target_bucket = "test-1cp-security"
    target_prefix = "logs/s3/"
  }
}

variable "secret_manager_iam_role_name" {
    description = "The name to be used for the Secret Manager IAM role."
    default     = "EKSSecretManager"
    type        = string
  }

  variable "secret_manager_iam_policy_name" {
    description = "The name to be used for the Secret Manager IAM policy."
    default     = "AllowEKSToReadFromSecretsManager"
    type        = string
  }

 variable "secret_manager_create_iam_role" {
   description = "Whether or not to create the IAM role for the Secret Manager."
   default     = true
   type        = bool
 }

 variable "secret_manager_create_iam_policy" {
   description = "The name to be used for the Secret Manager IAM policy."
   default     = true
   type        = bool
 }

 variable "aws_transcribe_create_iam_policy_name" {
   description = "Policy name to be used to create IAM policy for AWS Transcribe."
   type        = string
   default     = "EKSTranscribe"
 }

variable "aws_transcribe_iam_role_name" {
  type = string
}
