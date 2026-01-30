terraform {
  backend "s3" {
    bucket         = "aws-secure-vpc-terraform-shared-tfstate-b697ea"
    key            = "prod/vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aws-secure-vpc-terraform-shared-tflock"
    encrypt        = true
  }
}
