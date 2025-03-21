### TERRAFORM BASE INFRASTRUCTURE MODULES

This guide will walk you through the steps to deploy the infrastructure. Please follow the instructions carefully and input the required variables as specified.

## Prerequisites

- Ensure you have Terraform installed on your machine.
- Have access to your cloud provider's credentials.

## Variables

Below are the variables you need to define in your `terraform.tfvars` file:

### AWS Region Variable

- `aws_region`: The AWS region where you want to deploy your infrastructure (e.g., "us-west-2").

### VPC and Subnet Variables

- `vpc_cidr_block`: The CIDR block for the VPC (e.g., "10.0.0.0/16").
- `vpc_name`: The name of the VPC.
- `subnet_cidr_blocks`: List of CIDR blocks for the subnets. Enter four. (e.g., ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]).
- `azs`: List of desired availability zones. Enter two availability zones within the selected region. (e.g., ["us-west-2a", "us-west-2b"]).

### EKS Variables

- `cluster_name`: The name of the EKS cluster.
- `node_group_name`: The name of the EKS node group.
- `instance_type`: The instance type to use for the EKS node group (e.g., "t2.medium").
- `desired_capacity`: The desired capacity of the EKS node group.
- `min_size`: The minimum size of the EKS node group.
- `max_size`: The maximum size of the EKS node group.
- `max_unavailable`: The maximum number of unavailable nodes during a rolling update.

### Load Balancer Variables

- `lb_name`: The name of the load balancer.
- `target_group_name`: The name of the target group.

### GitHub Variables

- `github_org`: The GitHub organization name where your repository is located.
- `github_repo`: The name of the GitHub repository containing your infrastructure code.

## Deployment Steps

1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Initialize Terraform:
    ```sh
    terraform init
    ```
NOTE: included with this repository is a `terraform.tfvars` file with arbitrary values for easy testing. Make sure to change these to your desired values. In a production environment, this file should not be pushed to a public repo (add to `.gitignore` file) as they can contain sensitive values.
    
4. Create a `terraform.tfvars` file and input your variable values:
    ```hcl
    aws_region = "us-east-1"
    vpc_cidr_block = "10.0.0.0/16"
    vpc_name = "my-vpc"
    subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
    azs = ["us-east-1a", "us-east-1b"]
    cluster_name = "my-cluster"
    node_group_name = "my-node-group"
    instance_type = "t2.medium"
    desired_capacity = 2
    min_size = 1
    max_size = 3
    max_unavailable = 1
    lb_name = "my-load-balancer"
    target_group_name = "my-target-group"
    github_org = tdthurston
    github_repo = ilios-base-tf-infra
    ```
5. Apply the Terraform configuration:
    ```sh
    terraform apply
    ```
6. Confirm the apply step by typing `yes` when prompted.

Your infrastructure should now be deployed (this can take up to 30 minutes or longer). If you encounter any issues, refer to the Terraform documentation or seek help from your cloud provider's support.

## Additional Information

For more details on each variable and their usage, please refer to the `variables.tf` file and the official Terraform documentation.
Note that this repository includes a terraform.tfvars file with arbitrary values for easy testing. Make sure to change these to your desired values.

