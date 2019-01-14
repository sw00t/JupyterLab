#!/bin/bash

# Destroy cluster
read -p "Destroy Universal Installer provisioned DC/OS cluster? (y/n) " -n1 -s c
if [ "$c" = "y" ]; then
echo
echo Response received: $c . Proceeding...
date
export AWS_DEFAULT_REGION=us-west-2
eval $(maws li <Your Account>)
terraform destroy
fi
