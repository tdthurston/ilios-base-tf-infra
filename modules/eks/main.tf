resource "aws_eks_cluster" "ilios_cluster" {
  name = var.cluster_name

  role_arn = aws_iam_role.cluster_role.arn
  version  = "1.31"

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [aws_security_group.cluster_sg.id]
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role.cluster_role,
    aws_iam_role_policy_attachment.cluster_role_attachment
  ]
}

resource "aws_iam_role" "irsa_role" {
  name = "irsa-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "irsa_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.irsa_role.name
}

resource "aws_iam_role" "cluster_role" {
  name = "cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_eks_node_group" "ilios_node_group" {
  cluster_name    = aws_eks_cluster.ilios_cluster.name
  node_group_name = "ilios-node-group"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = var.private_subnet_ids
  instance_types  = [var.instance_type]
  capacity_type   = "ON_DEMAND"

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  tags = {
    "Name" = "ilios-worker-node"
  }

  depends_on = [
    aws_iam_role.node_group_role,
    aws_iam_role_policy_attachment.worker_node_policy_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
    aws_iam_role_policy_attachment.ec2_container_policy_attachment,
  ]
}

resource "aws_iam_role" "node_group_role" {
  name = "node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "worker_node_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_security_group" "cluster_sg" {
  name        = "eks-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id      = var.vpc_id
}

resource "aws_security_group" "node_group_sg" {
  name        = "eks-node-group-sg"
  description = "Security group for EKS node group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "eks_cluster_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cluster_sg.id
}

resource "aws_security_group_rule" "eks_cluster_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cluster_sg.id
}

resource "aws_security_group_rule" "eks_node_group_ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.node_group_sg.id
}

resource "aws_security_group_rule" "eks_node_group_ingress_https" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.node_group_sg.id
}

resource "aws_security_group_rule" "eks_node_group_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.node_group_sg.id
}

