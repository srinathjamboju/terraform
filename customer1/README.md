[//]: # (BEGIN_TF_DOCS)


## Providers

| Name | Version |
|------|---------|
| aws | 3.72.0 |
| terraform | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.vault_endpoint](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.ea_egress_rules_to_kafka](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_traffic_within_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.elasticsearch_egress_rules](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_vpc_endpoint.interface_endpoint_for_vault](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/vpc_endpoint) | resource |
| [terraform_remote_state.vpc_config](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Modules

| Name | Source | Version |
|------|--------|---------|
| cog-caep-tst-usea1-2 | terraform-aws-modules/eks/aws | v18.2.0 |
| eks\_iam\_resources | git@github.com:Smarsh/sre-cog-tf-mod-aws-eks-iam-resources.git | 0.2.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_load\_balancer\_controller\_iam\_policy\_name | The name to be used for the AWS Load Balancer Controller IAM policy. | `string` | `"ELBController"` | no |
| aws\_load\_balancer\_controller\_iam\_role\_name | The name to be used for the AWS Load Balancer Controller IAM role. | `string` | `"ELBController"` | no |
| cert\_manager\_iam\_policy\_name | The name to be used for the AWS Load Balancer Controller IAM policy. | `string` | `"AllowCertManagerToModifyRoute53Records"` | no |
| cert\_manager\_iam\_role\_name | The name to be used for the Cert Manager IAM role. | `string` | `"EKSCertManager"` | no |
| cluster\_autoscaler\_iam\_policy\_name | The name to be used for the Cluster Autoscaler IAM policy. | `string` | `"ClusterAutoscaler"` | no |
| cluster\_autoscaler\_iam\_role\_name | The name to be used for the Cluster Autoscaler IAM role. | `string` | `"ClusterAutoscaler"` | no |
| cognition\_buckets | Map containing key/value pairs being the 'key' the kind of bucket and the 'value' the name of the bucket | `map(any)` | `{}` | no |
| ea\_kafka\_ip\_addresses\_list | List of IP addresses to communicate with kafka on the Enterprise Archive Environment. | `list(string)` | `[]` | no |
| eks\_cluster\_enable\_log\_types | A list of the desired control plane logging to enable. | `list(string)` | n/a | yes |
| eks\_cluster\_endpoint\_private\_access | Indicates whether or not the Amazon EKS private API server endpoint is enabled. | `bool` | `true` | no |
| eks\_cluster\_endpoint\_public\_access | Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`. | `bool` | `false` | no |
| eks\_cluster\_endpoint\_public\_access\_cidrs | CIDR of the addresses that will be allowed in the SG to contact the cluster public endpoint. | `list(string)` | n/a | yes |
| eks\_cluster\_log\_retention\_in\_days | Number of days to retain log events. | `number` | n/a | yes |
| eks\_cluster\_name | Name of the EKS cluster. Also used as a prefix in names of related resources. | `string` | n/a | yes |
| eks\_cluster\_node\_groups | Map of map of node groups to create. | `any` | n/a | yes |
| eks\_cluster\_node\_groups\_defaults | Map of values to be applied to all node groups. | `any` | n/a | yes |
| eks\_cluster\_vpc | The VPC to be used for creating the cluster in | `string` | `""` | no |
| eks\_create\_cluster | Whether to create the EKS cluster. | `bool` | `true` | no |
| eks\_enable\_irsa | Whether to create OpenID Connect Provider for EKS to enable IRSA. | `bool` | `true` | no |
| eks\_iam\_policy\_name | The name to be used for the EKS IAM policy. | `string` | `"EKS"` | no |
| eks\_kubernetes\_version | Kubernetes version to use in the control planes of the EKS cluster. | `string` | n/a | yes |
| eks\_manage\_aws\_auth | Whether to apply the aws-auth configmap file. | `bool` | `false` | no |
| eks\_subnets | The subnets where the cluster and workers will be place in | `list(string)` | `[]` | no |
| eks\_write\_kubeconfig | Whether to write a Kubectl config file containing the cluster configuration. Saved to `kubeconfig_output_path`. | `bool` | `false` | no |
| elasticsearch\_egress\_rules | List of subnets where Elasticsearch is deployed by platform team. | `list(string)` | n/a | yes |
| external\_dns\_iam\_policy\_name | The name to be used for the External DNS IAM policy. | `string` | `"ExternalDNS"` | no |
| external\_dns\_iam\_role\_name | The name to be used for the External DNS IAM role. | `string` | `"ExternalDNS"` | no |
| iam\_policies\_name\_prefix | Prefix to be used on all IAM policies created by this module. | `string` | `"Policy"` | no |
| iam\_roles\_name\_prefix | Prefix to be used on all IAM roles created by this module. | `string` | `"Role"` | no |
| region | AWS Region, e.g us-west-2 | `any` | n/a | yes |
| vault\_endpoint\_service\_name | Service name of Vault endpoint service | `string` | n/a | yes |
| vpc\_cidr | The CIDR block of the VPC. | `string` | n/a | yes |
| vpc\_create\_database\_subnet\_group | Controls if database subnet group should be created. | `bool` | `false` | no |

## Outputs

No outputs.

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> v1.0.4 |
| aws | 3.72.0 |

## Values

Configuration passed to modules and resources is declared in the file [values.tfvars](values.tfvars). This file
**must be** considered as the source of truth for the configuration of the infrastructure. Configuration values **must not**
be declared anywhere else other than in this file!

## Development

- This project uses [Semantic Versioning](https://semver.org/).
- After cloning this repo and moving into it, you must run make hook in order to install the git hooks.

[//]: # (END_TF_DOCS)