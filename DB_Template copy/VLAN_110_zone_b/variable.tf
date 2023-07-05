variable "subnet" {
  type    = string
  default = "VLAN_140"
}

variable "region_zone" {
  type    = string
  default = "eu-west-1b"
}

variable "route_table_name" {
  type    = string
  default = "RT-CORE-CDE"
}

variable "cidr_block" {
  type    = string
  default = "172.31.140.0/24"
}

variable "vpc_id" {
  type    = string
  default = "vpc-08e550317d5c717e1"
}
