variable "aws_region" {
  description = "AWS Region for the S3 and DynamoDB"
  default     = "us-west-1"
}

variable "state_bucket" {
  description = "S3 bucket for holding Terraform state files. Must be globally unique."
  type        = string
  default     = "asg-backend-195"
}
