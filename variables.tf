variable "project_name" { type = string }
variable "environment" { type = string }
variable "aws_region" { type = string }

variable "vpc_cidr" { type = string }

variable "az_count" {
  type        = number
  description = "How many AZs to span (2 recommended)."
  default     = 2
}

variable "enable_nat_gateway" {
  type        = bool
  description = "NAT Gateway costs money; keep enabled for private subnets to reach internet."
  default     = true
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "asg_min" {
  type    = number
  default = 1
}

variable "asg_max" {
  type    = number
  default = 2
}

