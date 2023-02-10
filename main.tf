resource "aws_s3_bucket_server_side_encryption_configuration" "state_bucket" {
  bucket = aws_s3_bucket.state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "state_bucket" {
  bucket = aws_s3_bucket.state_bucket.id

  versioning_configuration {
    status     = "Enabled"
    mfa_delete = var.s3_versioning_mfa_delete
  }
}

resource "aws_s3_bucket" "state_bucket" {
  bucket = module.this.id

  tags = module.this.tags
}

resource "aws_dynamodb_table" "state_table" {
  name           = "${module.this.id}${module.this.delimiter}lock"
  read_capacity  = var.dynamodb_read_capacity
  write_capacity = var.dynamodb_write_capacity
  hash_key       = "LockID" # https://www.terraform.io/docs/backends/types/s3.html#dynamodb_table

  server_side_encryption {
    enabled = true
  }

  lifecycle {
    ignore_changes = [read_capacity, write_capacity]
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = module.this.tags
}
