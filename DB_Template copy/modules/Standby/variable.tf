# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
}
# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}
# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type        = string
}
# Terraform State S3Bucket
variable "db_remote_state_bucket" {
  description = "S3 Bucket Name"
  type        = string
}
# Teraform State S3BucketKey
variable "db_remote_state_key" {
  description = "S3 Bucket Name"
  type        = string
}
# EC2 Image Name
variable "image_name" {
  description = "Image Name"
  type        = string
}
# EC2 Instance role name
variable "instance_role_name" {
  description = "EC2 Role Name"
  type        = string
}
# Subnet name
variable "subnet_name" {
  type = string
}
# Availability Zone
variable "availability_zone" {
  type = string
}

# # Subnet name data
# variable "subnet_name_data" {
#   type = string
# }

# IP-addres data
# variable "data_ip" {
#   type        = string
# }

#VPC name
variable "vpc_name" {
  type = string
}

variable "volume_size_data" {
  type = string
}

variable "volume_size_oracle" {
  type = string
}

variable "volume_size_redo" {
  type = string
}
variable "private_ip" {
  type = string

}
