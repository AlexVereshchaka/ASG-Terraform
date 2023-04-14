resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

/* resource "aws_subnet" "public" {
  count      = 2
  cidr_block = "10.0.${count.index}.0/24"
  vpc_id     = aws_vpc.vpc.id
  tags = {
    Name = "public-subnet-${count.index}"
  }
} */

resource "aws_subnet" "private" {
  count      = 2
  cidr_block = "10.0.${count.index + 2}.0/24"
  vpc_id     = aws_vpc.vpc.id
  tags = {
    Name = "private-subnet-${count.index}"
  }
}

resource "aws_network_interface" "ni" {
  count = 2
  subnet_id   = aws_subnet.private.id
  private_ips = ["172.16.10.100", "172.16.10.100"][count.index]

  tags = {
    Name = "primary_network_interface"
  }
}