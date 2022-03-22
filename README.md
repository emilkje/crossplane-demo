
# Crossplane with Azure provider

## Prequisites

* local kubernetes cluster
* Azure CLI
* `az login` with an account with Owner permissions on the subscription or parent Management Group

## Getting started

Follow the shell scripts and provision the resources

```sh
./01-install-crossplane.sh
./02-install-crossplane-cli.sh
./03-configure-azure-environment.sh
./04-install-azure-provider.sh
./05-configure-azure-provider.sh

# provision resource group
# and wait for resource group to finish 
# (.status.provisioningState == Succeeded)
kubectl apply -f resources/ResourceGroup.yaml

# provision storage account (metadata.name must be globally unique)
kubectl apply -f resources/StorageAccount.yaml

```