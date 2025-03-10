module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.31.0"
  
  cluster_name    = var.cluster_name
  cluster_version = "1.31"
  
  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids
  
  manage_aws_auth_configmap = true
  
  aws_auth_roles = var.aws_auth_roles

  tags = var.tags
  
  cluster_security_group_id = var.cluster_security_group_id != null ? var.cluster_security_group_id : null
  
  eks_managed_node_group_defaults = {
    vpc_security_group_ids = []  # Empty list instead of null
  }
  
  eks_managed_node_groups = {
    main = {
      name           = var.node_group_name
      instance_types = [var.instance_type]
      min_size       = var.min_size
      max_size       = var.max_size
      desired_size   = var.desired_capacity
      subnet_ids     = var.private_subnet_ids
      tags           = var.tags
      
      vpc_security_group_ids = var.node_group_security_group_id != null ? [var.node_group_security_group_id] : []
      
      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ]
      
      update_config = {
        max_unavailable = var.max_unavailable
      }
      
      tags = var.tags

    }
  }
  
  node_security_group_additional_rules = {
    ingress_ssh = {
      description      = "Allow SSH access"
      protocol         = "tcp"
      from_port        = 22
      to_port          = 22
      type             = "ingress"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    ingress_http = {
      description      = "Allow HTTP access"
      protocol         = "tcp"
      from_port        = 80
      to_port          = 80
      type             = "ingress"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    egress_all = {
      description      = "Allow all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }
  
  cluster_security_group_additional_rules = {
    ingress_http = {
      description      = "Allow HTTP access"
      protocol         = "tcp"
      from_port        = 80
      to_port          = 80
      type             = "ingress"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    egress_all = {
      description      = "Allow all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }
}