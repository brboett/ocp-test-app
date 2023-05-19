#########################
## LOCALS SECTION #######
#########################

# Assigns current date to a variable
locals {

  # Build Time
  build_time = formatdate("YYYYMMDD", timestamp())

  # Amazon Linux Packages
  pkgs_lin_amaz = "tree git unzip wget curl jq sed"
}