resource "aws_subnet" "VLAN_140" {
  vpc_id                                = var.vpc_id
  cidr_block                            = var.cidr_block
  availability_zone                     = var.region_zone
  map_public_ip_on_launch               = false
  tags = {
    Name                                = var.subnet
  }

  lifecycle {
    prevent_destroy = true
  }

}

resource "aws_route_table_association" "a" {
  subnet_id                             = aws_subnet.VLAN_140.id
  route_table_id                        = data.aws_route_table.selected.id
}


data "aws_route_table" "selected" {
    tags = {
    Name = var.route_table_name
  }
}
