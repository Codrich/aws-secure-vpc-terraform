variable "aws_region" {
  description = "AWS region to create the backend resources in."
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Project name used for tagging and naming."
  type        = string
  default     = "aws-secure-vpc-terraform"
}

variable "environment" {
  description = "Environment label for backend resources."
  type        = string
  default     = "shared"
}

variable "force_destroy_bucket" {
  description = "If true, allows Terraform to destroy the S3 bucket even if it contains objects. Keep false for safety."
  type        = bool
  default     = false
}
