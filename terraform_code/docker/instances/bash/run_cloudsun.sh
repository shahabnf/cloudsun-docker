#!/bin/bash
# change permission for bash folder
chmod 777 bash/*

# login to ECR
aws ecr get-login-password --region us-east-1 | docker login -u AWS --password-stdin 629376172886.dkr.ecr.us-east-1.amazonaws.com

# Create NameSpace 
kubectl create ns cloud
kubectl create ns sun

# Deploy cloud application and use NodePort service to publish it
kubectl apply -f bash/deployment-cloud.yaml -n cloud --record
kubectl apply -f bash/serviceNodePort-cloud.yaml -n cloud --record

# Deploy sun application and use NodePort service to publish it
kubectl apply -f bash/deployment-sun.yaml -n sun --record
kubectl apply -f bash/serviceNodePort-sun.yaml -n sun --record
