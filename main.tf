module "network" {
  source = "./network"

  cidr_block = "10.0.0.0/16"
  name = "my-vpc"
  private_subnets = [
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]
  primary_network_interfaces = [
    "172.16.10.100",
    "172.16.10.101",
  ]
  nlb_name = "my-nlb"
  target_group_name = "my-target-group"
  target_group_port = 80
  instance_security_group_name_prefix = "instance"
}
