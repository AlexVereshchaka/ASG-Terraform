# Создание Security Group для EC2 Instance


/// Поправить
resource "aws_security_group" "instance" {
  vpc_id = aws_vpc.vpc
  name_prefix = "instance"
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}