# start minikube
minikube start

# set minikube Docker daemon
eval $(minikube -p minikube docker-env)

echo Minikube has been deployed and docker environment set

# create image
if [ -f "Dockerfile" ]
then
 docker build -t kishan-kubechallenge-img .
else
  echo "No Dockerfile found, image cannot be created"
fi

# set default namespace
kubectl config set-context --current --namespace=default

# verify
docker images | grep "kishan-kubechallenge-img"

echo Docker image has been created from provided Dockerfile

echo Now applying all the YAML files for deployment

kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/config_map.yaml
kubectl apply -f k8s/deployment.yaml

kubectl get service
kubectl get all
minikube ip

#get port of the Service
PORT=$(kubectl get service kube-challenge-service | awk 'FNR>1 {print $5}' | awk -F':|/' '{print $2}')

ENDPOINT=$(minikube ip):${PORT}

# test curl
curl ${ENDPOINT} -w '\n'
