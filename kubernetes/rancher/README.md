## Instalação do rancher via HELM
Link Official: https://rancher.com/docs/rancher/v2.x/en/installation/install-rancher-on-k8s/

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
kubectl create namespace k8s-manager

kubectl apply -f https://github.com/jetstack/cert-manager/releases/latest/download/cert-manager.yaml

helm install rancher rancher-latest/rancher \
  --namespace k8s-manager \
  --set hostname=rancher.k8s.manager

## Verificando a instalação
kubectl -n k8s-manager rollout status deploy/rancher
kubectl -n k8s-manager get deploy rancher