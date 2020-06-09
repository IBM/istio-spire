#!/bin/sh

export PATH=$PATH:../kind/bin

kubectl delete namespace spire

kubectl apply -f spire-tutorials/k8s/quickstart/spire-namespace.yaml

kubectl apply \
    -f spire-tutorials/k8s/quickstart/server-account.yaml \
    -f spire-tutorials/k8s/quickstart/spire-bundle-configmap.yaml \
    -f spire-tutorials/k8s/quickstart/server-cluster-role.yaml

kubectl apply \
    -f spire-tutorials/k8s/quickstart/server-configmap.yaml \
    -f spire-tutorials/k8s/quickstart/server-statefulset.yaml \
    -f spire-tutorials/k8s/quickstart/server-service.yaml

kubectl apply \
    -f spire-tutorials/k8s/quickstart/agent-account.yaml \
    -f spire-tutorials/k8s/quickstart/agent-cluster-role.yaml

kubectl apply \
    -f spire-tutorials/k8s/quickstart/agent-configmap.yaml \
    -f spire-tutorials/k8s/quickstart/agent-daemonset.yaml

kubectl wait --for=condition=Ready pod/spire-server-0 -n spire
kubectl wait --for=condition=Ready pod -l app=spire-agent -n spire
