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

/* Если нам надо выбрать конкретный интерфейс для  */
/* data "aws_network_interfaces" "example" {
  filter {
    name   = "tag:Name"
    values = ["my-network-interface"]
  }
}

network_interface {
    network_interface_id = var.network_interface_id
    device_index         = 0
  } */

