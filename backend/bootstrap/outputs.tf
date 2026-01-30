output "tf_state_bucket_name" {
  description = "S3 bucket name for Terraform remote state."
  value       = aws_s3_bucket.tf_state.bucket
}

output "tf_lock_table_name" {
  description = "DynamoDB table name for Terraform state locking."
  value       = aws_dynamodb_table.tf_lock.name
}

output "aws_region" {
  description = "Region where backend resources were created."
  value       = var.aws_region
}
