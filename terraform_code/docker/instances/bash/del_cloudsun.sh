#!/bin/bash
kubectl delete service/cloud -n cloud
kubectl delete deployment.apps/cloud -n cloud

kubectl delete service/sun -n sun
kubectl delete deployment.apps/sun -n sun

kubectl delete ns cloud
kubectl delete ns sun