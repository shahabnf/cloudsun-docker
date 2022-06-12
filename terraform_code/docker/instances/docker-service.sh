#!/bin/bash
# Install Docker, enable service, add user to Docker group
sudo yum update -y
sudo yum upgrade -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user