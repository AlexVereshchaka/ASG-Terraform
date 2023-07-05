terraform {
  required_version = "~> 1.4"

  backend "s3" {
    bucket  = "terraform-state-procard"
    key     = "Prod/Subnet/CDE/VLAN_140_zone_b/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55"
    }
  }
}
