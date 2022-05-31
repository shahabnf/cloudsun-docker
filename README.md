[![tfsec](https://github.com/shahabnf/cloudsun-docker/actions/workflows/tfsec.yml/badge.svg)](https://github.com/shahabnf/cloudsun-docker/actions/workflows/tfsec.yml)

# cloudsun-docker
Cloud Sun - Docker - AWS ECR

# ECR Repository name
ECR_REPOSITORY: shahab-lab1-repo

# ECR authentication
aws ecr get-login-password --region us-east-1 | docker login -u AWS ${ECR} --password-stdin

# ssh key name
ssh key name: docker-dev
ssh-keygen -t rsa -f  docker-dev

# terraform 
terraform init
terraform apply --auto-approve

# S3 name
ecr-pictures/cloud
ecr-pictures/sun

# Docker cloud 
cd cloud
docker build -t cloud:v1.0 .
docker run -d -p 8080:80 cloud:v1.0

# Docker sun 
cd ../sun
docker build -t sun:v1.0 .
docker run -d -p 8081:80 sun:v1.0
