#!/bin/bash
git clone https://github.com/shahabnf/cloudsun-docker
cd cloudsun-docker/terraform_code/s3-ecr
terraform init
terraform apply --auto-approve
cd ../docker/instances
# Check it work on not
# ssh-keygen -t rsa -f docker-prod 
ssh-keygen -q -t rsa -f docker-prod <<< y
terraform init
terraform apply --auto-approve
