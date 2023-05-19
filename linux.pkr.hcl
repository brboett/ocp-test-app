#########################
### BUILD SECTION #######
#########################
build {

  sources = ["source.amazon-ebs.source_lin_amaz"]

  provisioner "shell" {    
    inline = [
      "echo 'Waiting for OS to fully boot'",
      "sleep 60s"
    ]
  }

  provisioner "shell" {    
    only = ["amazon-ebs.source_lin_amaz"]
    inline = [
      "echo 'Installing Updates'",
      "sudo rm -rf /var/run/yum.pid",
      "sudo yum update -y > /dev/null",
      "sleep 30s"
    ]
  }

  provisioner "shell" {    
    only = ["amazon-ebs.source_lin_amaz"]
    inline = [
      "echo 'Installing Packages'",
      "sudo rm -rf /var/run/yum.pid",
      "sudo yum install -y ${local.pkgs_lin_amaz} > /dev/null"
    ]
  }

  provisioner "shell" {    
    inline = [
      "echo 'Running Script'"
    ]
  }

  # Amazon Linux Script
  provisioner "shell" {    
    only   = ["amazon-ebs.source_lin_amaz"]
    script = "scripts/amaz.sh"
  }

  # Troubleshooting -Pause the Packer build
  provisioner "breakpoint" {
    disable     = true    
    note        = "This is disabled with 'true'"
  }

  provisioner "shell" {    
    inline = [
      "echo 'Cleaning Up'",
      "sudo rm -rf /opt/build"
    ]
  }

  # provisioner "shell" {  #     
  #     inline = ["echo 'Rebooting...'"]
  # }

  # provisioner "shell" {  #     
  #     inline = ["sudo reboot now"]
  # }
}