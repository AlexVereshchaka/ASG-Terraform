terraform {
  backend "s3" {
  bucket         = "asg-backend-194"
    key            = "modules/ec2/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }
  required_version = ">= 1.0.2"
}

resource "aws_autoscaling_group" "asg" {
  name                 = var.asg_name
  launch_configuration = aws_launch_template.example.arn
  vpc_zone_identifier  = [var.subnet_ids]
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity

  /* tag {
    key                 = "Name"
    value               = "${var.asg_name}-instance"
    propagate_at_launch = true
  } */

  lifecycle {
    create_before_destroy = true
  }


  # Use the NLB health check for ASG
  health_check_type           = "ELB"
  health_check_grace_period   = 300
  termination_policies        = ["OldestInstance"]

  # Use the security group created in the network module
  /* security_groups             = var.security_group */

  /* tags = {
    Terraform   = "true"
    Environment = var.environment
  } */
}

resource "aws_lb_target_group_attachment" "asg_attachment" {
  target_group_arn = var.target_group_arn
  target_id        = var.target_group_arn
  port             = 80
}

resource "aws_launch_template" "example" {
  name_prefix   = "example"
  instance_type = var.instance_type

  image_id = var.ami_ids

  network_interfaces {
    associate_public_ip_address = true
    device_index                = 0

    security_groups = [var.security_group]

    subnet_id = var.subnet_ids
  }

  /* tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name}-instance"
    }
  } */

}


