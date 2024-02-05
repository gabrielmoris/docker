# Start Kubernetes in imperative Approach

**It works in Powershell**

## Deployment Object

1. Create the Dockerfile and build the image `docker build -t kub-first-app .`
2. Check if minikube is running `minikube status`. if not run `minikube start --driver=docker`
3. Create the repository in docker hub
4. Retag the img ` docker tag kub-first-app gabrielcmoris/kubernetes-first-app`
5. Push the image `docker push gabrielcmoris/kubernetes-first-app`
6. Send the image to kubernetes `kubectl create deployment first-app --image=gabrielcmoris/kubernetes-first-app`
7. Use `kubectl get deployments` to see the deployments and `kubectl get pods` to check the pods
8. use `kubectl delete deployment first-app` to delete a deployment
9. run `minikube dashboard` to see the dashboard

## Service Object

1. To create a service we run `kubectl expose deployment first-app --type=LoadBalancer --port=8080`
2. To see the services exposing `kubectl get services`
3. To see a service from minikube `minikube service first-app`. Since I am working in a virtual machine that is how I can get the ip exposed.
