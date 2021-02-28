#!/usr/bin/env bash

DBVER=v2.0.1

UZERID=`whoami`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -f dashboard.crt
rm -f dashboard.csr
rm -f dashboard.key
kubectl delete -f $DIR/../dashboardv2/dashboard.yml
helm delete metrics-server --purge
kubectl -n kubernetes-dashboard delete serviceaccount admin-user
kubectl delete ns kubernetes-dashboard