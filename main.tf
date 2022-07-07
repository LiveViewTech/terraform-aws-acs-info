terraform {
  required_version = ">= 1"
  required_providers {
    aws = ">= 3.50"
  }
}

data "aws_region" "current" {}
data "aws_iam_account_alias" "current" {}

data "aws_ssm_parameter" "acs_parameters" {
  name = "/acs/acsParameters"
}

locals {
  vpc_name = var.vpc_type == "non-edge" ? lookup(local.acs_info, "/acs/vpc/vpc-name") : lookup(local.acs_info, "/acs/vpc/vpc-name/${var.vpc_type}")

  acs_info = jsondecode(data.aws_ssm_parameter.acs_parameters.value)

  account_type = lookup(local.acs_info, "/acs/account/type", null)
  account_env  = lookup(local.acs_info, "/acs/account/env", null)

  role_permission_boundary_arn = lookup(local.acs_info, "/acs/iam/iamRolePermissionBoundary", null)
  user_permission_boundary_arn = lookup(local.acs_info, "/acs/iam/iamUserPermissionBoundary", null)
  powerbuilder_role_arn        = lookup(local.acs_info, "/acs/iam/powerbuilder-role", null)
  odo_security_group_arn       = lookup(local.acs_info, "/acs/odo/${local.vpc_name}-security-group", null)
  private_a_subnet_id          = lookup(local.acs_info, "/acs/vpc/${local.vpc_name}-private-a", null)
  private_b_subnet_id          = lookup(local.acs_info, "/acs/vpc/${local.vpc_name}-private-b", null)
  private_c_subnet_id          = lookup(local.acs_info, "/acs/vpc/${local.vpc_name}-private-c", null)
  private_d_subnet_id          = lookup(local.acs_info, "/acs/vpc/${local.vpc_name}-private-d", null)
  data_a_subnet_id             = lookup(local.acs_info, "/acs/vpc/${local.vpc_name}-data-a", null)
  data_b_subnet_id             = lookup(local.acs_info, "/acs/vpc/${local.vpc_name}-data-b", null)
  data_c_subnet_id             = lookup(local.acs_info, "/acs/vpc/${local.vpc_name}-data-c", null)
  data_d_subnet_id             = lookup(local.acs_info, "/acs/vpc/${local.vpc_name}-data-d", null)
  public_a_subnet_id           = lookup(local.acs_info, "/acs/vpc/${local.vpc_name}-public-a", null)
  public_b_subnet_id           = lookup(local.acs_info, "/acs/vpc/${local.vpc_name}-public-b", null)
  public_c_subnet_id           = lookup(local.acs_info, "/acs/vpc/${local.vpc_name}-public-c", null)
  public_d_subnet_id           = lookup(local.acs_info, "/acs/vpc/${local.vpc_name}-public-d", null)
  message_store_sg             = lookup(local.acs_info, "/acs/vpc/message-store-sg", null)
  horus_sg                     = lookup(local.acs_info, "/acs/vpc/horus-sg", null)
  zone_id                      = lookup(local.acs_info, "/acs/dns/zone-id", null)
}

data "aws_iam_policy" "role_permission_boundary" {
  count = local.role_permission_boundary_arn != null ? 1 : 0
  arn   = local.role_permission_boundary_arn
}
data "aws_iam_policy" "user_permission_boundary" {
  count = local.user_permission_boundary_arn != null ? 1 : 0
  arn   = local.user_permission_boundary_arn
}

data "aws_iam_role" "power_builder" {
  count = local.powerbuilder_role_arn != null ? 1 : 0
  name  = "PowerBuilder"
}

data "aws_vpc" "vpc" {
  tags = {
    Name : local.vpc_name
  }
}

data "aws_subnet" "private_a" {
  count = local.private_a_subnet_id != null ? 1 : 0
  id    = local.private_a_subnet_id
}
data "aws_subnet" "private_b" {
  count = local.private_b_subnet_id != null ? 1 : 0
  id    = local.private_b_subnet_id
}
data "aws_subnet" "private_c" {
  count = local.private_c_subnet_id != null ? 1 : 0
  id    = local.private_c_subnet_id
}
data "aws_subnet" "private_d" {
  count = local.private_d_subnet_id != null ? 1 : 0
  id    = local.private_d_subnet_id
}
data "aws_subnet" "data_a" {
  count = local.data_a_subnet_id != null ? 1 : 0
  id    = local.data_a_subnet_id
}
data "aws_subnet" "data_b" {
  count = local.data_b_subnet_id != null ? 1 : 0
  id    = local.data_b_subnet_id
}
data "aws_subnet" "data_c" {
  count = local.data_c_subnet_id != null ? 1 : 0
  id    = local.data_c_subnet_id
}
data "aws_subnet" "data_d" {
  count = local.data_d_subnet_id != null ? 1 : 0
  id    = local.data_d_subnet_id
}
data "aws_subnet" "public_a" {
  count = local.public_a_subnet_id != null ? 1 : 0
  id    = local.public_a_subnet_id
}
data "aws_subnet" "public_b" {
  count = local.public_b_subnet_id != null ? 1 : 0
  id    = local.public_b_subnet_id
}
data "aws_subnet" "public_c" {
  count = local.public_c_subnet_id != null ? 1 : 0
  id    = local.public_c_subnet_id
}
data "aws_subnet" "public_d" {
  count = local.public_d_subnet_id != null ? 1 : 0
  id    = local.public_d_subnet_id
}

data "aws_route53_zone" "zone" {
  count   = local.zone_id != null ? 1 : 0
  zone_id = local.zone_id
}
data "aws_acm_certificate" "cert" {
  count = local.zone_id != null ? 1 : 0
  // route53 zone includes a "." at the end of the zone name and the certificate can only be retrieved without the "."
  domain = trim(data.aws_route53_zone.zone[0].name, ".")
}

provider "aws" {
  alias   = "east"
  region  = "us-east-1"
  profile = var.profile
}

data "aws_acm_certificate" "virginia" {
  count    = local.zone_id != null ? 1 : 0
  provider = aws.east
  // route53 zone includes a "." at the end of the zone name and the certificate can only be retrieved without the "."
  domain = trim(data.aws_route53_zone.zone[0].name, ".")
}

data "aws_iam_account_alias" "east" {
  provider = aws.east
}

data "aws_db_subnet_group" "db_subnet_group" {
  name = "${local.vpc_name}-db-subnet-group"
}

data "aws_security_group" "odo_security_group" {
  count = local.odo_security_group_arn != null ? 1 : 0
  id    = local.odo_security_group_arn
}

data "aws_security_group" "message_store_group" {
  count = local.message_store_sg != null ? 1 : 0
  id    = local.message_store_sg
}

data "aws_security_group" "horus_security_group" {
  count = local.horus_sg != null ? 1 : 0
  id    = local.horus_sg
}
