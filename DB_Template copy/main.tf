module "Standby" {
  source = "./modules/Standby"

  aws_region             = "eu-west-1"
  availability_zone      = "eu-west-1b"
  instance_type          = "m6a.xlarge"
  db_remote_state_bucket = "terraform-state-procard"
  db_remote_state_key    = "Prod/EC2/DB-Standby/terraform.tfstate"
  image_name             = "Template_OracleLinux8_v3"
  instance_role_name     = "EC2-ClowdWatch-Role"
  instance_keypair       = "172.31.0.0"
  subnet_name            = "VLAN_140"
  vpc_name               = "Procard-DC"
  private_ip             = "172.31.140.27"

  # Disk size`s
  volume_size_data   = 500
  volume_size_oracle = 125
  volume_size_redo   = 100



}
