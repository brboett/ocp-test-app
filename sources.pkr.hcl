#########################
## SOURCE SECTION #######
#########################

# Amazon Linux
source "amazon-ebs" "source_lin_amaz" {

  ami_name      = "${var.ami_name_lin_amaz}-${local.build_time}" # Example: HNB-Win-2022-20220124 
  region        = var.aws_region
  instance_type = var.aws_inst_type
  source_ami    = data.amazon-ami.data_lin_amaz.id
  # ami_users       = var.aws_ami_users
  # snapshot_users  = var.aws_snapshot_users
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = "1"
    http_tokens                 = "required"
  }

  # VPC
  subnet_id = var.aws_subnet

  # SSH    
  ssh_username = "ec2-user"
  # ssh_interface = "public_ip"
  # temporary_key_pair_type = "ed25519"

  # Storage
  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/xvda"
    volume_size           = 100
    volume_type           = "gp2"
    encrypted             = true
    # kms_key_id            = var.aws_kms_key
  }

  # Tags
  run_tags = {
    Source  = "{{ .SourceAMIName }}"
    Version = "{{isotime `2006.01.02`}}"
    Name    = "Packer - AMI Creation for Amazon Linux"
  }

  snapshot_tags = {
    Source     = "{{ .SourceAMIName }}"
    Version    = "{{isotime `2006.01.02`}}"
    Name       = "${var.ami_name_lin_amaz}-${local.build_time}"
    OS         = "Amazon Linux 2"
    Identifier = "4c7b30bd-6653-4495"
    Packer     = "true"
  }

  tags = {
    Source     = "{{ .SourceAMIName }}"
    Version    = "{{isotime `2006.01.02`}}"
    Name       = "${var.ami_name_lin_amaz}-${local.build_time}"
    OS         = "Amazon Linux 2"
    Identifier = "4c7b30bd-6653-4495"
    Packer     = "true"
  }
}
