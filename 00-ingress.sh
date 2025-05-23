helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  --set controller.service.type=LoadBalancer \
  --set controller.service.loadBalancerIP="10.240.0.50" \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-internal"="true" \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-internal-subnet"="aks-subnet-name" \
  --set controller.nodeSelector."agentpool"="userpool" \
  --set controller.tolerations[0].key="node-role.kubernetes.io/system" \
  --set controller.tolerations[0].operator="Exists" \
  --set controller.tolerations[0].effect="NoSchedule"
