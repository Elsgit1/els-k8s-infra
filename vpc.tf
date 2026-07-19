# VPC and Subnets
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-1c", "us-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    Name = "eks-public-subnet"
  }

  private_subnet_tags = {
    Name = "eks-private-subnet"
  }

  tags = {
    Name = "eks-vpc"
  }
}
