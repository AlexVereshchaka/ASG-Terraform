terraform {
  /* backend "s3" {
    bucket         = "asg-backend-194"
    key            = "backend/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  } */
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }
  required_version = ">= 1.0.2"
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      "TerminationDate" = "Permanent",
      "Environment"     = "Development",
      "Team"            = "DevOps",
      "DeployedBy"      = "Terraform",
      "Application"     = "Terraform Backend",
      "OwnerEmail"      = "devops@example.com"
    }
  }
}


# Create an S3 bucket to store the state file in
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket
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
  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name        = var.state_bucket
    Description = "S3 Remote Terraform State Store"
  }
}
