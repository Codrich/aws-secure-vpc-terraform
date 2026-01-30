module "vpc" {
  source = "../../modules/vpc"

  name = "aws-secure-vpc-prod"
  cidr = "10.30.0.0/16"

  azs                  = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs  = ["10.30.0.0/24", "10.30.1.0/24"]
  private_subnet_cidrs = ["10.30.10.0/24", "10.30.11.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Project     = "aws-secure-vpc-terraform"
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}
