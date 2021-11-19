#!/bin/bash
#set -x

kubectl create namespace ${wp_namespace}
helm install -f ${wp_values} ${wp_service_name} stable/wordpress --namespace ${wp_namespace}
echo Password: $(kubectl get secret --namespace ${wp_namespace} ${wp_service_name} -o jsonpath="{.data.wordpress-password}" | base64 --decode)
echo "Wordpress installed!"
wp_ip=""
while [ -z $wp_ip ]; do
  echo "Waiting for Wordpress external IP"
  wp_ip=$(kubectl get svc --namespace ${wp_namespace} ${wp_service_name} --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
  [ -z "$wp_ip" ] && sleep 10
done
echo 'Found Wordpress external IP: '$wp_ip