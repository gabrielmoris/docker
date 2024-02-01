# Start Kubernetes in imperative Approach

1. Create the Dockerfile and build the image `docker build -t kub-first-app .`
2. Check if minikube is running `minikube status`. if not run `minikube start --driver=docker`
3. Send the image to kubernetes `kubectl create deployment first-app --image=`
