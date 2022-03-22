#!/usr/bin/bash

# Before we can start creating external resources in Azure we need to install 
# the crossplane provider to handle the requests from our cluster.

# Install the azure crossplane provider (change the image version to the latest release)
# https://github.com/crossplane/provider-azure/releases

kubectl crossplane install provider crossplane/provider-azure:v0.18.1