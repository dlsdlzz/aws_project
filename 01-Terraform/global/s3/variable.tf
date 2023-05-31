variable "bucket_name" {
  description = "the name of the s3 bucket, must be globally unique"
  type        = string
  default     = "aws03-terraform-state"
}

variable "table_name" {
  description = "the name of the dynamodb table. must be unique in this aws account"
  type        = string
  default     = "aws03-terraform-locks"
}
