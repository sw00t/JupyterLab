#!/bin/bash
# SW Jan 2019
# Time: ~12 min. Deploy one master, one public agent, five private agents:

export AWS_DEFAULT_REGION=us-west-2
eval $(maws li <Your Account>)
sudo ssh-add ~/.ssh/id_rsa

# List all DC/OS clusters attached to this system
#  dcos cluster list
#  sudo dcos cluster list

# Unattach all DC/OS clusters from this system
#  dcos cluster remove --all

# Backup, Delete existing kube config file
#  cp ~/.kube/config ~/.kube/config.backup
#  rm ~/.kube/config


# Main.tf configuration confirmation
read -p "Have you configured/updated main.tf ? (y/n)" -n1 -s c
if [ "$c" = "y" ]; then
  terraform init
  terraform plan --out=plan.out
  terraform apply "plan.out"
fi

mIP=0
promptValue() {
  read -p "Enter the above Master IP address: $1"": " val
  mIP=$val
}
promptValue ""
echo 'Entered value: '$mIP''
dcos cluster setup $mIP

dcos config set core.ssl_verify false
dcos node
dcos cluster list
sleep 5
open https://$mIP
dcos package install dcos-enterprise-cli --yes

date
echo Prep is complete -- DC/OS is now ready.
