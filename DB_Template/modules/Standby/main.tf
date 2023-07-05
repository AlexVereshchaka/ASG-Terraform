resource "aws_instance" "AWSPRDDWHDB_B_140_27" {
  ami                    = data.aws_ami.DB_image.id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  iam_instance_profile   = var.instance_role_name
  private_ip             = var.private_ip
  vpc_security_group_ids = ["${data.aws_security_group.selected.id}"]
  subnet_id              = data.aws_subnet.instance_subnet.id
  root_block_device {
    volume_size = var.volume_size_data
  }
  dynamic "ebs_block_device" {
    for_each = range(6)
    content {
      device_name = "/dev/sd${element(["f", "g", "h", "i", "j", "k"], ebs_block_device.key)}"
      volume_size = var.volume_size_data
      encrypted   = true
      volume_type = "st1"
    }
  }

  ebs_block_device {
    device_name = "/dev/sdl"
    volume_size = var.volume_size_oracle
    encrypted   = true
    volume_type = "st1"
  }
  ebs_block_device {
    device_name = "/dev/sdm"
    volume_size = var.volume_size_redo
    iops        = 3000
    encrypted   = true
    volume_type = "gp3"
  }

}
# resource "aws_volume_attachment" "ebs_backup" {
#   device_name = "/dev/sdh"
#   volume_id   = data.aws_ebs_volume_attachment.ebs_backup
#   instance_id = aws_instance.DB.id
# }

