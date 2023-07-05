# Get Latest AWS AMI ID f
data "aws_ami" "DB_image" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "tag:Name"
    values = [var.image_name]
  }
}

# Get Latest AZsf
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_iam_role" "instance_profile" {
  name = var.instance_role_name
}

data "aws_vpc" "procard_vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}"]
  }
}

data "aws_subnet" "instance_subnet" {
  filter {
    name   = "tag:Name"
    values = ["${var.subnet_name}"]
  }
}

data "aws_security_group" "selected" {
  vpc_id = data.aws_vpc.procard_vpc.id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}

data "aws_subnets" "subnet_ids_data" {
  tags = {
    Name = var.subnet_name
  }
}

# data "aws_ebs_volume" "ebs_backup" {
#   most_recent = true
#   filter {
#     name   = "volume-type"
#     values = ["gp2"]
#   }
#   filter {
#     name   = "tag:Name"
#     values = ["Example"]
#   }
# }
