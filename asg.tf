# Создание Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  name                 = "my-asg"
  min_size             = 1
  max_size             = 2
  launch_configuration = aws_launch_configuration.server.id
  vpc_zone_identifier  = [aws_subnet.private.*.id]
}

# Создание Launch Configuration для Auto Scaling Group
resource "aws_launch_configuration" "server" {
  name            = "my-launch-config"
  image_id        = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  security_groups = ["aws_security_group.instance.id"]
}

