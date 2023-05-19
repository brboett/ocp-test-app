#########################
## DATA SECTION #########
#########################

# Amazon Linux
data "amazon-ami" "data_lin_amaz" {
  filters = {
    name                = var.os_lin_amaz
    architecture        = "x86_64"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = [var.os_owner_amaz]
  region      = var.aws_region
}
