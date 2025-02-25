output "cluster_name" {
  value = var.cluster_name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.ilios_cluster.endpoint
}

output "cluster_security_group_id" {
  value = aws_security_group.cluster_sg.id
}

output "node_group_security_group_id" {
  value = aws_security_group.node_group_sg.id
}

output "node_group_role_arn" {
  value = aws_iam_role.node_group_role.arn
}

output "cluster_role_arn" {
  value = aws_iam_role.cluster_role.arn
}

output "cluster_id" {
  value = aws_eks_cluster.ilios_cluster.id
}

output "instance_type" {
  value = var.instance_type
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.ilios_cluster.certificate_authority.0.data
}