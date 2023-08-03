# Filename: main.tf
# Purpose: Deploys 100 test EC2 instances with tags
# Author: Mathew Ericson mericson@commvault.com
# Date: 2022-03-05
#
# Instructions
# Set AWSPROPS variales to match you VPC, Subnet, Instance Profile.data "" "name" {
# Run:
# terraform plan
# terraform apply -auto-approve
# when done:
# terraform destroy -auto-approve
#
# Note: Instances are not Spot instance as Commvault cannot restore Spot instances
# and in-place restore testing was being performed with these instances.data "" "name" {
# AMIs
# ami-0c8cc5cb6544b3370 - x86 ClearOS fast boot
# ami-084237e82d7842286 - ARM 64-Bit Amazon Linux 2
#
# Note: Relies on Commvault Backup & Recovery BYOL AMI product being deployed in the account so that the 'CommvaultBackupAndRecovery AWS IAM Role' exists
#
variable "awsprops" {
    type = map
    default = {
    region = "us-east-1"
    az = "us-east-1a"
    vpc = "INSERT-YOUR-VPC-ID"
    ami = "ami-084237e82d7842286"
    itype = "t4g.micro"
    subnet = "subnet-0873f033d1c7f120c"
    publicip = false
    keyname = "INSERT-YOUR-KEYPAIR-NAME"
    instanceprofile = "CommvaultBackupAndRecovery"
    volume_type = "gp3"
    encrypt_disk = "true"
    delete_disk_on_termination = "true"
  }
}

provider "aws" {
  region = lookup(var.awsprops, "region")
}

#
# BLOCK 1-10
#
resource "aws_instance" "instance1"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "nginx-frontend-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance2"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "nginx-frontend-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
    # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }

}

resource "aws_instance" "instance3"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "nginx-frontend-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
    # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }

}

resource "aws_instance" "instance4"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "nginx-frontend-004"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
    # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }

}

resource "aws_instance" "instance5"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "nginx-frontend-005"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
    # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }

}

resource "aws_instance" "instance6"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "erp-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
    # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }

}

resource "aws_instance" "instance7"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "erp-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
    # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }

}

resource "aws_instance" "instance8"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "argocd-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
    # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }

}

resource "aws_instance" "instance9"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "argocd-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
    # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }

}

resource "aws_instance" "instance10"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "argocd-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
    # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }

}
#
# BLOCK 2 - 11-20
#
resource "aws_instance" "instance11"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "jenkins-pipe-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
    # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }

}

resource "aws_instance" "instance12"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "jenkins-pipe-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance13"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "bastion-host-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance14"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "bastion-host-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance15"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "bastion-host-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance16"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "bastion-host-004"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance17"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "bastion-host-005"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance18"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "crypto-mining-experiment-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance19"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "crypto-mining-experiment-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance20"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "opengpt-experiment-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}
#
# BLOCK 3 - 21-30
#
resource "aws_instance" "instance21"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "opengpt-experiment-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance22"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "opengpt-experiment-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance23"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "sap-hana-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance24"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "sap-hana-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance25"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "sap-hana-reports-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance26"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "mysql-analytics-01"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance27"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "mysql-analytics-101"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance28"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "pgsql-reporting-01"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance29"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "pgsql-reporting-101"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance30"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "pgsql-reporting-201"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}
#
# BLOCK 4 - 31-40
#
resource "aws_instance" "instance31"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "sqlserver-inmem-01"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance32"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "sqlserver-inmem-02"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance33"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "gitlabce-experiment-999"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance34"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "gitea-test-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance35"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "jenkins-cicd-prod-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance36"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "jenkins-cicd-prod-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance37"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "jenkins-cicd-prod-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance38"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "gitlab-prod-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance39"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "gitlab-prod-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance40"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "gitlab-prod-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}
#
# BLOCK 5 - 41-50
#
resource "aws_instance" "instance41"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "gitlab-prod-004"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance42"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "gitlab-prod-005"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance43"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "commvault-hyperscalex-node1"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance44"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "commvault-hyperscalex-node2"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance45"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "commvault-hyperscalex-node3"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance46"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "commvault-hyperscalex-node4"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance47"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "commvault-hyperscalex-node5"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance48"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "commvault-hyperscalex-node6"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance49"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "readonly-decom-veeam-backup-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance50"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "readonly-decom-veritas-nbkp-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}
#
# BLOCK 6 - 51-60
#
resource "aws_instance" "instance51"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "openvpn-access-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance52"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "openvpn-access-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance53"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "openvpn-access-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance54"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "kali-pentest-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance55"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "kali-pentest-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance56"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "mariadb-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance57"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "kali-pentest-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance58"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "kali-pentest-004"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance59"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "kali-pentest-005"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance60"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "hashi-vagrant-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}
#
# BLOCK 7 - 61-70
#
resource "aws_instance" "instance61"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "hashi-vagrant-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance62"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "hashi-consul-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance63"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "hashi-consul-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance64"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "hashi-terraform-iac-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance65"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "hashi-terraform-iac-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance66"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "hashi-terraform-iac-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance67"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "nginx-plus-prem-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance68"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "nginx-plus-prem-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance69"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "nginx-plus-prem-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance70"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "opengpt-experiment-004"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}
#
# BLOCK 8 - 71-80
#
resource "aws_instance" "instance71"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "zscaler-zerotrust-ZTNA-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance72"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "zscaler-zerotrust-ZTNA-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance73"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "zscaler-zerotrust-ZTNA-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance74"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "zscaler-zerotrust-ZTNA-004"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance75"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "citrix-adc-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance76"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "citrix-adc-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance77"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "pfsense-fw-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance78"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "pfsense-fw-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance79"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "nessus-vuln-scan-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance80"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "nessus-vuln-scan-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}
#
# BLOCK 9 - 81-90
#
resource "aws_instance" "instance81"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "nessus-vuln-scan-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }

}

resource "aws_instance" "instance82"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "netapp-bluexp-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance83"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "netapp-bluexp-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance84"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "pagerduty-alert-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance85"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "pagerduty-alert-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance86"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "wordpress-docsite-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance87"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "wordpress-docsite-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance88"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "wordpress-docsite-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance89"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "prometheus-infra-monitoring-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance90"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "prometheus-infra-monitoring-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}
#
# BLOCK 10 - 91-100
#
resource "aws_instance" "instance91"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "prometheus-infra-monitoring-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance92"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "grafana-cloudops-dash-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance93"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "grafana-cloudops-dash-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance94"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "grafana-secops-dash-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance95"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "grafana-secops-dash-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance96"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "kraken-transcoder-001"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance97"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "kraken-transcoder-002"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance98"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "kraken-transcoder-003"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance99"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "kraken-transcoder-004"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}

resource "aws_instance" "instance100"{
  ami           = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  availability_zone = lookup (var.awsprops, "az")
  subnet_id = lookup(var.awsprops, "subnet")
  iam_instance_profile = lookup(var.awsprops, "instanceprofile")
  ebs_optimized = true
  key_name = lookup(var.awsprops, "keyname")
  user_data = <<EOF
#!/bin/bash
yum update -y
mkdir -p /data >> /tmp/output 2>&1
chmod 777 /data >> /tmp/output 2>&1
mkfs -t ext3 /dev/nvme1n1 >> /tmp/output 2>&1
mount /dev/nvme1n1 /data >> /tmp/output 2>&1
head -c 2G </dev/urandom >/data/myfile1 
head -c 2G </dev/urandom >/data/myfile2
head -c 2G </dev/urandom >/data/myfile3
head -c 2G </dev/urandom >/data/myfile4
head -c 2G </dev/urandom >/data/myfile5
echo "this is test data for Commvault" >> /data/readme.txt

EOF
  tags = {
	Name = "kraken-transcoder-005"
	Data-Classification = "Production"
	"Cvlt:Usage" = "Test workloads"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
  # data disk
  ebs_block_device {
    volume_type = "gp3"
    device_name = "/dev/xvdf"
    encrypted = "true"
    delete_on_termination = "true"
    volume_size = 11
  }
}
