#!/usr/bin/bash

# Before creating any resources, we need to configure 
# an Azure cloud provider resource in Crossplane, which stores the 
# cloud account information in it. All the requests from Crossplane 
# to Azure Cloud will use the credentials attached to this provider resource. 

# The following command assumes that you have a crossplane-azure-provider-key.json 
# file (generated in step 03) that belongs to the account you’d like Crossplane to use.

export BASE64ENCODED_AZURE_ACCOUNT_CREDS=$(base64 crossplane-azure-provider-key.json | tr -d "\n")

cat > provider.yaml <<EOF
---
apiVersion: v1
kind: Secret
metadata:
  name: azure-account-creds
  namespace: crossplane-system
type: Opaque
data:
  credentials: ${BASE64ENCODED_AZURE_ACCOUNT_CREDS}
---
apiVersion: azure.crossplane.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: azure-account-creds
      key: credentials
EOF

kubectl apply -f provider.yaml

unset BASE64ENCODED_AZURE_ACCOUNT_CREDS