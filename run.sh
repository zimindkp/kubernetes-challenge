# start minkube
minikube start

# set minikube Docker daemon


echo Minikube has been deployed and docker environment set

# create image
if exist Dockerfile ( docker build -t kishan-kubechallenge-img . ) else (	echo "No Dockerfile found, image cannot be created" )

# set default namespace
kubectl config set-context --current --namespace=default

# verify
docker images | findstr "kishan-kubechallenge-img"

echo Docker image has been created from provided Dockerfile

echo Now applying all the YAML files for deployment

kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/config_map.yaml
kubectl apply -f k8s/deployment.yaml

kubectl get service
kubectl get all
minikube ip

# Get tunnel IP for minikube (on Windows, the Minikube IP does not work)
start cmd /k minikube service --url kube-challenge-service
