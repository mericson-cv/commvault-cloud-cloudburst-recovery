# Filename: main.tf
# Purpose: Deploys 1 test EC2 instance with tags
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
# Note: Requires that the subnet is in the same Availability Zone (AZ) as your Commvault Backup & Recovery instance (to allow use of Commvault HotAdd restore)
# Note2: Relies on deployment of Commvault Backup & Recovery BYOL product from AWS Marketplace, so that the AWS IAM 'CommvaultBackupAndRecovery' role is available.
#
variable "awsprops" {
    type = map
    default = {
    region = "us-east-1"
    az = "us-east-1a"
    vpc = "INSERT-YOUR-VPC-ID"
    ami = "ami-0c8cc5cb6544b3370"
    itype = "t3.micro"
    subnet = "INSERT-SUBNET-ID-YOUR-COMMVAULT-INSTANCE-IS-IN"
    publicip = false
    keyname = "INSERT-YOUR-KEYPAIRNAME"
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
  tags = {
	Name = "nginx-frontend-001"
	Data-Classification = "Production"
        "Cvlt:Usage" = "Test workload"
  }

  # root disk
  root_block_device {
    volume_type           = lookup(var.awsprops, "volume_type")
    encrypted             = lookup(var.awsprops, "encrypt_disk")
    delete_on_termination = lookup(var.awsprops, "delete_disk_on_termination")
  }
}
