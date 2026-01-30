module "vpc" {
  source = "../../modules/vpc"

  name = "aws-secure-vpc-dev"
  cidr = "10.10.0.0/16"

  azs = ["us-east-1a", "us-east-1b"]

  public_subnet_cidrs  = ["10.10.0.0/24", "10.10.1.0/24"]
  private_subnet_cidrs = ["10.10.10.0/24", "10.10.11.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = "dev"
    Project     = "aws-secure-vpc-terraform"
    ManagedBy   = "Terraform"
  }
}
