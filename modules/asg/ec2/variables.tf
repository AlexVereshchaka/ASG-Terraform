variable "ami" {
  description = "The ID of the AMI to use for the instance"
}

variable "instance_type" {
  description = "The type of instance to launch"
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
}

variable "security_group_ids" {
  description = "The security group IDs to associate with the instance"
  type        = list(string)
}
variable "network_interface_id" {
  type        = string
  description = "The ID of the network interface to attach to the EC2 instance"
}

resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = var.security_group_ids

  network_interface {
    network_interface_id = var.network_interface_id
    device_index         = 0
  }
}
