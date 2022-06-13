# Terraform AWS ACS Info

This module retrieves some basic [ACS](https://bitbucket.org/liveviewtech/aws-acs) information and exposes them via outputs. 

**Note:** This module does not create nor update any resources.

## Usage

```hcl
module "acs" {
  source = "bitbucket.org/liveviewtech/terraform-aws-acs-info.git?ref=v2.0.0"
}
```

After defining the module you can then retrieve the information you need (see available [outputs](#output) below) using the interpolation syntax:

```hcl
...
  vpc_id = module.acs.vpc.id
```

## Requirements

* Terraform version 1.0.0 or greater

## Input

| Name     | Type   | Description                              | Default Value |
|----------|--------|------------------------------------------|---------------|
| vpc_type | string | Retrieve VPC info for a certain VPC type | non-edge      |
| profile  | string | Terrraform provider profile being used   | default       |

```vpc_type``` must be one of the following: non-edge, edge, operations, workspaces. (Not all types are avaliable for every AWS account.)

## Output

| Name                          | Type                                                                                                                          | Description                                                        |
|-------------------------------|-------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| account_type                  | string                                                                                                                        | The type of account (business, service, platform, etc)             |
| account_env                   | string                                                                                                                        | The three-letter environment designation of the account            |
| role_permissions_boundary     | [object](https://www.terraform.io/docs/providers/aws/d/iam_policy.html#attributes-reference)                                  | The IAM role permissions boundary policy object                    |
| user_permissions_boundary     | [object](https://www.terraform.io/docs/providers/aws/d/iam_policy.html#attributes-reference)                                  | The IAM user permissions boundary policy object                    |
| powerbuilder_role             | [object](https://www.terraform.io/docs/providers/aws/d/iam_role.html#attributes-reference)                                    | The IAM PowerBuilder role object object                            |
| vpc                           | [object](https://www.terraform.io/docs/providers/aws/d/vpc.html#attributes-reference)                                         | The VPC object                                                     |
| private_subnet_ids            | list(string)                                                                                                                  | List of subnet_ids for the private subnets in the specified VPC    |
| public_subnet_ids             | list(string)                                                                                                                  | List of subnet_ids for the public subnets in the specified VPC     |
| data_subnet_ids               | list(string)                                                                                                                  | List of subnet_ids for the data subnets in the specified VPC       |
| private_subnets               | list([object](https://www.terraform.io/docs/providers/aws/r/subnet.html#attributes-reference))                                | List of private subnet objects in the specified VPC                |
| public_subnets                | list([object](https://www.terraform.io/docs/providers/aws/r/subnet.html#attributes-reference))                                | List of public subnet object in the specified VPC                  |
| data_subnets                  | list([object](https://www.terraform.io/docs/providers/aws/r/subnet.html#attributes-reference))                                | List of data subnet objects in the specified VPC                   |
| route53_zone                  | [object](https://www.terraform.io/docs/providers/aws/r/route53_zone.html#attributes-reference)                                | The Route53 zone object                                            |
| certificate                   | [object](https://www.terraform.io/docs/providers/aws/d/acm_certificate.html#attributes-reference)                             | The default region's ACM certificate object)                       |
| certificate_virginia          | [object](https://www.terraform.io/docs/providers/aws/d/acm_certificate.html#attributes-reference)                             | The us-east-1 region's ACM certificate object)                     |
| db_subnet_group               | [object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_subnet_group#attributes-reference) | The database subnet group for RDS in the specified VPC object      |
| elasticache_subnet_group_name | string                                                                                                                        | The elasticache subnet group name used to specify subnets in a VPC |
| odo_security_group            | [object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group#attributes-reference)  | The security group to allow access to applications through Odo     |
| message_store_security_group  | [object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group#attributes-reference)  | The security group to allow access to the Message Store            |

**Note about returning objects**: Because objects are returned (as opposed to just values), autocomplete may not work. Just add on the key to the end out the output accessor. Even though autocomplete won't work, those values will still be correctly returned.
