#!/usr/bin/bash

# create namespace
kubectl create namespace crossplane-system

# add helm repo
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update

# install crossplane into crossplane-system namespace
helm install crossplane --namespace crossplane-system crossplane-stable/crossplane