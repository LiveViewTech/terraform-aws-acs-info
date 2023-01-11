output "account_type" {
  value = local.account_type
}
output "account_env" {
  value = local.account_env
}

output "role_permissions_boundary" {
  value = local.role_permission_boundary_arn != null ? data.aws_iam_policy.role_permission_boundary[0] : null
}
output "user_permissions_boundary" {
  value = local.user_permission_boundary_arn != null ? data.aws_iam_policy.user_permission_boundary[0] : null
}

output "powerbuilder_role" {
  value = local.powerbuilder_role_arn != null ? data.aws_iam_role.power_builder[0] : null
}

output "vpc" {
  value = data.aws_vpc.vpc
}
output "private_subnet_ids" {
  value = local.private_a_subnet_id != null ? [data.aws_subnet.private_a[0].id, data.aws_subnet.private_b[0].id, data.aws_subnet.private_c[0].id, data.aws_subnet.private_d[0].id] : null
}
output "public_subnet_ids" {
  value = local.public_a_subnet_id != null ? [data.aws_subnet.public_a[0].id, data.aws_subnet.public_b[0].id, data.aws_subnet.public_c[0].id, data.aws_subnet.public_d[0].id] : null
}
output "data_subnet_ids" {
  value = local.data_a_subnet_id != null ? [data.aws_subnet.data_a[0].id, data.aws_subnet.data_b[0].id, data.aws_subnet.data_c[0].id, data.aws_subnet.data_d[0].id] : null
}
output "private_subnets" {
  value = local.private_a_subnet_id != null ? [data.aws_subnet.private_a[0], data.aws_subnet.private_b[0], data.aws_subnet.private_c[0], data.aws_subnet.private_d[0]] : null
}
output "public_subnets" {
  value = local.public_a_subnet_id != null ? [data.aws_subnet.public_a[0], data.aws_subnet.public_b[0], data.aws_subnet.public_c[0], data.aws_subnet.public_d[0]] : null
}
output "data_subnets" {
  value = local.data_a_subnet_id != null ? [data.aws_subnet.data_a[0], data.aws_subnet.data_b[0], data.aws_subnet.data_c[0], data.aws_subnet.data_d[0]] : null
}

output "route53_zone" {
  value = local.zone_id != null ? data.aws_route53_zone.zone[0] : null
}
output "certificate" {
  value = local.zone_id != null ? data.aws_acm_certificate.cert[0] : null
}
output "certificate_virginia" {
  value = local.zone_id != null ? data.aws_acm_certificate.virginia[0] : null
}

output "db_subnet_group" {
  value = data.aws_db_subnet_group.db_subnet_group
}

output "elasticache_subnet_group_name" {
  value = "${local.vpc_name}-elasticache-subnet-group"
}

output "otel_url" {
  value = local.otel_url != null ? local.otel_url : null
}

output "odo_security_group" {
  value = local.odo_security_group_arn != null ? data.aws_security_group.odo_security_group[0] : null
}

output "message_store_security_group" {
  value = local.message_store_sg != null ? data.aws_security_group.message_store_group[0] : null
}

output "horus_security_group" {
  value = local.horus_sg != null ? data.aws_security_group.horus_security_group[0] : null
}
