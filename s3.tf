provider "aws" {
  region = var.aws_region
}

locals {
  aws_s3_terraform_lock = "stackit-${var.stackId}"
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

