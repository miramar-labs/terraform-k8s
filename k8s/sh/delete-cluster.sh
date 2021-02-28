#!/usr/bin/env bash

if [[ "$#" -ne 1 ]]; then
    echo "must supply local sudo password as arg";exit 1
fi

UZERID=`whoami`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Terraform - un-provision VMs
pushd $DIR/../../cluster/local.esxi/terraform-k8s
terraform init
terraform destroy -force
popd
