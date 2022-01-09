provider "aws" {
  region = var.aws_region
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  lower   = true
  upper   = false
}

locals {
  aws_s3_terraform_lock = "aws-eks-fid-${random_string.suffix.result}"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = local.aws_s3_terraform_lock

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_locks" {
  name         = local.aws_s3_terraform_lock
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

