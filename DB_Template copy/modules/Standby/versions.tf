terraform {
  required_version = "~> 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# Provider Block
provider "aws" {
  profile = "default"
}

terraform {
  # Set Your Bucket here
  backend "s3" {
    bucket  = var.db_remote_state_bucket
    key     = var.db_remote_state_key
    region  = var.region
    encrypt = true
  }
}
