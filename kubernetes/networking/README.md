# Networking

## Schema Demo:

![alt text](image.png)

## Start project

- Enable virtual machine (minikube) `minikube start --driver=docker`
- For the beginning, hardcode in `users-app.js` all the calls to `/auth`, then When I enable the /auth I can revert the changes
- Upload to docker hub `docker build -t gabrielcmoris/kub-demo-users .`, `docker push gabrielcmoris/kub-demo-users`
- In the folder /kubernetes I will create all files and run with `kubectl apply -f users-deployment.yaml -f users-service.yaml`
- To check the deployment in minikube, run: `minikube service users-service`
- Change in `/users-app.js` the calls to `/auth again to put a env variable`
- Upload to docker hub again `docker build -t gabrielcmoris/kub-demo-auth .`, `docker push gabrielcmoris/kub-demo-auth`
- Now with both containers **users API** and **Auth api** in the same container, the communication will work through `localhost`
- To manage network between different pods we need to use other way. Instead of `http://${process.env.AUTH_ADDRESS}/token/` we use `http://${process.env.AUTH_SERVICE_SERVICE_HOST}/token/` being AUTH_SERVICE the name of the service in capitals. This is an env variable generated automatically from Kubernetes.
- Afterwards we can reapply everything `kubectl apply -f users-deployment.yaml -f users-service.yaml -f auth-deployment.yaml -f auth-service.yaml`
