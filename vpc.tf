module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "project-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
  public_subnets  = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  intra_subnets = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]

  public_subnet_names = ["project-subnet-public-a", "project-subnet-public-b", "project-subnet-public-c"]
  private_subnet_names = ["project-subnet-private-a", "project-subnet-private-b", "project-subnet-private-c"]
  intra_subnet_names = ["project-subnet-protected-a", "project-subnet-protected-b", "project-subnet-protected-c"]

  enable_dns_support = true
  enable_dns_hostnames = true
  enable_nat_gateway = true  

  tags = {
    project = "app"
  }
}
