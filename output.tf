// VPC outputs
output "vpc" {
  value = data.aws_vpc.vpc
}
output "private_subnet_ids" {
  value = local.private_a_subnet_id != null ? [data.aws_subnet.private_a[0].id, data.aws_subnet.private_b[0].id, data.aws_subnet.private_c[0], data.aws_subnet.private_d[0]] : null
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

// DNS outputs
output "route53_zone" {
  value = local.zone_id != null ? data.aws_route53_zone.zone[0] : null
}
output "certificate" {
  value = local.zone_id != null ? data.aws_acm_certificate.cert[0] : null
}

// RDS Outputs
output "db_subnet_group" {
  value = data.aws_db_subnet_group.db_subnet_group
}
