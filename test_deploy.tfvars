# This file can be used to test the deployment of the terraform code using arbitrary values.
# Run terraform apply -var-file=test_deploy.tfvars to deploy the infrastructure
# In a real world scenario, the values in this file would be replaced with the actual values
# for the deployment

vpc_region = "us-west-2"
vpc_cidr_block = "10.0.0.0/16"
vpc_name = "test-vpc"
subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
azs = ["us-west-2a", "us-west-2b"]

cluster_name = "test-cluster"
node_group_name = "test-node-group"
instance_type = "t2.micro"
desired_capacity = 2
min_size = 1
max_size = 3
max_unavailable = 1

lb_name = "test-lb"
target_group_name = "test-target-group"