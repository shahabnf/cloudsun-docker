# cloudsun-docker
Cloud Sun - Docker - AWS ECR

ssh key name: docker-dev

# Docker cloud 
cd cloud
docker build -t cloud:v1.0 .
docker run -d -p 8080:80 cloud:v1.0

# Docker sun 
cd ../sun
docker build -t sun:v1.0 .
docker run -d -p 8081:80 sun:v1.0
