### TERRAFORM BASE INFRASTRUCTURE MODULES

This guide will walk you through the steps to deploy the infrastructure. Please follow the instructions carefully and input the required variables as specified.

## Prerequisites

- Ensure you have Terraform installed on your machine.
- Have access to your cloud provider's credentials.

## Variables

Below are the variables you need to define in your `variables.tf` file:

### AWS Region Variable

- `aws_region`: The AWS region where you want to deploy your infrastructure (e.g., "us-west-2").

### VPC and Subnet Variables

- `vpc_cidr_block`: The CIDR block for the VPC (e.g., "10.0.0.0/16").
- `vpc_name`: The name of the VPC.
- `subnet_cidr_blocks`: List of CIDR blocks for the subnets (e.g., ["10.0.1.0/24", "10.0.2.0/24"]).
- `azs`: List of desired availability zones (e.g., ["us-west-2a", "us-west-2b"]).

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

## Deployment Steps

1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Initialize Terraform:
    ```sh
    terraform init
    ```
4. Create a `terraform.tfvars` file and input your variable values:
    ```hcl
    vpc_cidr_block = "10.0.0.0/16"
    vpc_name = "my-vpc"
    subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
    azs = ["us-west-2a", "us-west-2b"]
    cluster_name = "my-cluster"
    node_group_name = "my-node-group"
    instance_type = "t2.medium"
    desired_capacity = 2
    min_size = 1
    max_size = 3
    max_unavailable = 1
    lb_name = "my-load-balancer"
    target_group_name = "my-target-group"
    ```
5. Apply the Terraform configuration:
    ```sh
    terraform apply
    ```
6. Confirm the apply step by typing `yes` when prompted.

Your infrastructure should now be deployed. If you encounter any issues, refer to the Terraform documentation or seek help from your cloud provider's support.

## Additional Information

For more details on each variable and their usage, please refer to the `variables.tf` file and the official Terraform documentation.

A .tfvars file for testing has been included in this repository.

