variable "dynamodb_read_capacity" {
  type        = number
  default     = 5
  description = "DynamoDB read capacity units"
}

variable "dynamodb_write_capacity" {
  type        = number
  default     = 5
  description = "DynamoDB write capacity units"
}

variable "s3_versioning_mfa_delete" {
  type        = bool
  default     = false
  description = <<EOT
    A boolean that indicates that versions of S3 objects can only be deleted with MFA. (Terraform cannot apply changes
    of this value; https://github.com/terraform-providers/terraform-provider-aws/issues/629)
  EOT
}