
#---------------------------------------------------------#
#                 Terraform Introduction                  #
#                 Docker Container Host                   #
#                Build EC2 Instances + EIP                #
#             Security group: 22,80,8080-8089             #
#---------------------------------------------------------#

# Specify AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = "~> 1.2.0" # 1.2.0 or above and below 1.3.0
}

#  Define the provider
provider "aws" {
  region = "us-east-1"
}

# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Data source for IAM Lab Profile
data "aws_iam_instance_profile" "iam_lab" {
  name = "LabInstanceProfile"
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Data block to retrieve the default VPC id
data "aws_vpc" "default" {
  default = true
}

# Define tags locally
locals {
  default_tags = merge(module.globalvars.default_tags, { "env" = var.env })
  prefix       = module.globalvars.prefix
  name_prefix  = "${local.prefix}-${var.env}"
}

# Retrieve global variables from the Terraform module
module "globalvars" {
  source = "../../modules/globalvars"
}

# Reference subnet provisioned by 01-Networking 
resource "aws_instance" "my_amazon" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.docker_key.key_name
  vpc_security_group_ids      = [aws_security_group.docker_sg.id]
  associate_public_ip_address = false
  iam_instance_profile        = data.aws_iam_instance_profile.iam_lab.name
  user_data                   = "${file("bash/install_kind.sh")}"
  
  root_block_device {
    volume_size = 16
  }
  
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-Amazon-Linux"
    }
  )
}

# Adding SSH key to Amazon EC2
resource "aws_key_pair" "docker_key" {
  key_name   = local.name_prefix
  public_key = file("${local.name_prefix}.pub")
}

# Security Group
resource "aws_security_group" "docker_sg" {
  name        = "Allow_ssh_web"
  description = "Allow SSH & Web inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.sg_port_number
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.cidr_RG]
    }
  }

  ingress {
    description      = "Container Web from everywhere"
    from_port        = 8080
    to_port          = 8089
    protocol         = "tcp"
    cidr_blocks      = [var.cidr_RG]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.cidr_RG]
    # ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-sg"
    }
  )
}

# Elastic IP for docker host
resource "aws_eip" "static_eip" {
  instance = aws_instance.my_amazon.id
  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-eip"
    }
  )
}
