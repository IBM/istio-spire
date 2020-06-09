#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PATH=$PATH:$DIR/istio-1.5.4/bin/:$DIR/bin:$DIR/spire

TMPFILE=/tmp/tmp.tmp

if [ ! -d istio_patch ]
  then cp -R istio-1.5.4/install/kubernetes/operator/ istio_patch

  for file in `find istio_patch -name "*.yaml" | xargs grep -l "volumes:"`
    do echo $file
    ./patch/patch.py $file ./patch/volumes.txt ./patch/volumeMounts.txt > $TMPFILE
    mv $TMPFILE $file
  done

  for file in `find istio_patch -name "*.yaml" | xargs grep -l "proxyv2"`
    do echo $file
    sed -i 's/proxyv2/proxyv2-spire/g' $file
  done

  # sed -i 's/proxyv2/proxyv2-spire/g' istio_patch/profiles/default.yaml
  sed -i 's/cluster.local/example.org/g' istio_patch/profiles/default.yaml
  sed -i 's/imagePullPolicy: ""/imagePullPolicy: "IfNotPresent"/g' istio_patch/profiles/default.yaml
fi

cd docker
./build_proxy_image.sh

cd ..

echo Configuring Spiffe identities for Istio services
./spire/setup_spire.sh

echo Running Istio
istioctl manifest apply --set installPackagePath=./istio_patch --set profile=./istio_patch/profiles/default.yaml

kubectl wait --for=condition=Ready pod -l app=istio-ingressgateway -n istio-system
kubectl wait --for=condition=Ready pod -l app=istiod -n istio-system
kubectl wait --for=condition=Ready pod -l app=prometheus -n istio-system
