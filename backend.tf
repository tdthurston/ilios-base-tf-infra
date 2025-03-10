terraform {
  backend "s3" {
    bucket = "ilios-tf-backend"
    key    = "base-infrastructure/terraform.tfstate"
    region = "us-east-1"
  }
}