# Kubernetes Challenge

Deploy this application to [Minikube](https://github.com/kubernetes/minikube) and customise the environment variable to display your name.

```
$ curl $(minikube ip)
Hello Dan!
```

## Instructions

- Fork this repo
- Build the Docker image
- Write yaml files for a deployment, service, ingress and configmap
- Deploy your application to Minikube
- You should be able to `curl` Minikube's ip and retrieve the string `Hello {yourname}!`
- Commit your files to Github

------------
# SOLUTION

I followed the instructions and successfully deployed my application to Minikube on a MacBook Pro (MacOS). The YAML files I used are available in the k8s folder in the repository. Here are the steps I took:

**Prerequisites**

While the run.sh command calls the prereq script to install prerequisites if necessary, it is critical to know which packages are required for Minikube. It is easier to install all the prerequisites for Minikube using the Homebrew package manager. If you do not have it installed, you can install using the following command in a terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Once HomeBrew is installed, we can then install Minikube including the prerequisites:
```bash
brew update && brew install kubectl && brew cask install docker minikube virtualbox
```
After completion, the following packages will be installed:
```bash
docker --version                # Docker version 18.06.1-ce, build e68fc7a
docker-compose --version        # docker-compose version 1.22.0, build f46880f
minikube version                # minikube version: v0.30.0
kubectl version --client        # Client Version: version.Info{Major:"1", .....
```
Again, this will be handled by the run.sh script, but worth knowing the required packages.

### 1. Obtain the repository files

Clone the git repo to a working folder to deploy the application on Minikube.

```bash
git clone https://github.com/zimindkp/kubernetes-challenge kishankubechallenge
```

### 2. Execute the run.sh file

```bash
cd kishankubechallenge\
chmod 755 run.sh
chmod 755 prereq.sh
./run.sh
```

This will do all of the following:
- Verify prerequisites are installed, and if not, will install them
- Start Minikube and set minikube Docker daemon
- Create Docker image
- Apply all the YAML files (in the **k8s** folder) for deployment 
- Test application by running `curl minikube_ip`
- Test application by opening the endpoint in a browser

##### (Optional) Stop Minikube and delete repository files

- To stop minikube, simply enter the following:
`minikube stop`

- If you want to delete the repository files to save space:
```bash
cd kishankubechallenge
git rm -r -q .
cd .. 
rm -rf kishankubechallenge
```

## DESIGN

In the k8s folder there are 4 YAML files used for deployment:

1. **config_map.yaml**
	- this stores the environment variable USERNAME which will be called by the deployment.yaml file
2. **ingress.yaml**
	- this manages external access to the services in our cluster using a service in service.yaml
3. **service.yaml**
	- this is an abstraction layer that provides an accessible IP and port 
4. **deployment.yaml**
	- this is the main yaml file to create our containers using the specifications highlighted in the file
	-  it will create containers based off the image we create from the provided Dockerfile

Once our minikube VM is started in the run.sh script, we first create the image to use for our containers, in this case I named it kishan-kubechallenge-img.
`docker build -t kishan-kubechallenge-img .`

Then we apply our YAML files for deployment:
```bash
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/config_map.yaml
kubectl apply -f k8s/deployment.yaml
```
Once we have verifed all the services are running as expected, we test our application by accessing the IP and port we provided earlier:
`curl ${ENDPOINT} -w '\n'` 

Also test by opening in a browser:
`open http://${ENDPOINT}`

## TESTING

This script was tested on my Macbook Pro (macOS Big Sur 11.6) and the output logs from the run.sh script are available in the testrun_minikube.log file in the repository. 

There is also an additional screenshot of the browser window showing the application working as expected named as endpointtest.png
