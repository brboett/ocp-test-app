################################
## VARIABLE DEFINITIONS ########
################################
variable "aws_region" {
  type        = string
  description = "AWS Region for the AMI"
}

variable "aws_inst_type" {
  type        = string
  description = "AWS AMI Instance Type"
}

variable "aws_subnet" {
  type        = string
  description = "AWS Subnet"
}

variable "ami_name_lin_amaz" {
  type        = string
  description = "AMI Name for Amazon Linux"
}

variable "os_owner_amaz" {
  type        = string
  description = "OS Owner # for Amazon"
}

variable "os_lin_amaz" {
  type        = string
  description = "OS Name for Amazon Linux"
}
