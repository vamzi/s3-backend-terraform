output "terraform_lock_name" {
  description = "random name generated for terraform lock"
  value = local.aws_s3_terraform_lock
}

output "aws_s3_bucket_name" {
  description = "s3 bucket name for terraform state file"
  value = aws_s3_bucket.terraform_state.bucket
}

output "aws_s3_bucket_domain_name" {
  description = "s3 bucket domain name for terraform state file"
  value = aws_s3_bucket.terraform_state.bucket_regional_domain_name
}

output "aws_dynamo_db_table_name" {
  description = "dynamo db file for terraform state file locking"
  value = aws_dynamodb_table.terraform_state_locks.id
}

output "aws_region_name" {
  description = "aws region name"
  value = aws_s3_bucket.terraform_state.region
}