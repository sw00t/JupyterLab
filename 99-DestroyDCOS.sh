#!/bin/bash

# Destroy cluster
read -p "Destroy terraform provisioned DC/OS cluster? (y/n) " -n1 -s c
if [ "$c" = "y" ]; then
echo
echo Response received: $c . Proceeding...
date
export AWS_DEFAULT_REGION=us-west-2
eval $(maws li <Your Account>)
terraform destroy
fi



#echo Unattach DC/OS cluster, remove terraform cluster files, backup+remove kube config, remove pem files, remove dcos license.
#  dcos cluster remove --all
#  rm plan.out
#  rm terraform.tfstate*
#  cp ~/.kube/config ~/.kube/config.backup
#  rm ~/.kube/config
#  rm private-key.pem
#  rm public-key.pem
#  rm license.txt
