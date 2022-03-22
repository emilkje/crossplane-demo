#!/usr/bin/bash

# In order to manage resources in Azure, you must provide credentials 
# for a Azure service principal that Crossplane can use to authenticate. 
# This assumes that you have already set up the Azure CLI client with your credentials.

# create a JSON file that contains all the information needed to connect and authenticate to Azure
az ad sp create-for-rbac -n "Crossplane Controller" --sdk-auth --role Owner > crossplane-azure-provider-key.json

# export client id from generated credentials
export AZURE_CLIENT_ID=$(cat crossplane-azure-provider-key.json | grep -o '"clientId": "[^"]*' | grep -o '[^"]*$')

# add required Azure Active Directory permissions
# Azure Active Directory
#   |- Application.ReadWrite.All
#   |- Directory.ReadWrite.All
az ad app permission add \
    --id ${AZURE_CLIENT_ID} \
    --api 00000002-0000-0000-c000-000000000000 \ # Azure Active Directory resource
    --api-permissions 1cda74f2-2616-4834-b122-5cb1b07f8a59=Role 78c8a3c8-a07e-4b9e-af1b-b5ccab50a175=Role

# grant assigned permissions
az ad app permission grant --id ${AZURE_CLIENT_ID} --api 00000002-0000-0000-c000-000000000000 --expires never

# grant admin consent to the app registration
az ad app permission admin-consent --id "${AZURE_CLIENT_ID}"