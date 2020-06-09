#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PATH=$PATH:$DIR/../../bin:$DIR/../../istio-1.5.4/bin

kubectl delete service/echo  service/web deployment.apps/echo-v1 deployment.apps/web-v1

kubectl apply -f deploy.yaml -f gateway.yaml

kubectl get deployment web-v1 -o yaml | istioctl kube-inject -f - | kubectl apply -f -
kubectl get deployment echo-v1 -o yaml | istioctl kube-inject -f - | kubectl apply -f -
