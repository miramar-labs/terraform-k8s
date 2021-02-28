#!/usr/bin/env bash

if [[ "$#" -ne 1 ]]; then
    echo "must supply local sudo password as arg";exit 1
fi

UZERID=`whoami`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Terraform - provision VMs
pushd $DIR/../../cluster/local.esxi/terraform-k8s
terraform init
terraform apply -auto-approve
popd

# Ansible post-provision tasks
pushd $DIR/../../cluster/local.esxi

ansible-playbook ../../k8s/create.yml \
	--extra-vars ansible_become_password=$1

# Ansible deploy k8s
ansible-playbook ../../k8s/deploy.yml \
	--extra-vars ansible_become_password=$1

popd

# Deploy k8s Dashboard
bash deploy-dashboard.sh