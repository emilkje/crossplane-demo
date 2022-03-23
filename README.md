
# Crossplane with Azure provider

## Prequisites

* local kubernetes cluster
* Azure CLI
* `az login` with an account with Owner permissions on the subscription or parent Management Group

## Getting started

Follow the shell scripts and provision the resources

```sh
# install crossplane helm repo into crossplane-system
./01-install-crossplane.sh

# downlaod kubectl crossplane extensions
./02-install-crossplane-cli.sh

# create service principal and give 
# permissions to provision infrastructure
./03-configure-azure-environment.sh

# use `kubectl crossplane` to install the azure provider.
# installs packages and crds into the cluster
./04-install-azure-provider.sh

# create a secret based on ste-3 and 
# configure the provider with said secret
./05-configure-azure-provider.sh

# provision resource group
# and wait for resource group to finish 
# (.status.provisioningState == Succeeded)
kubectl apply -f resources/ResourceGroup.yaml

# provision storage account (metadata.name must be globally unique)
kubectl apply -f resources/StorageAccount.yaml

```