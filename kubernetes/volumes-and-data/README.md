# Volumes

In kubernetes the volume lifetime depends on the pod lifetime. Volumes are inside of the pods.
Kubernetes volumes have many different drivers and types.
Kubernetes volumes survive Container restarts and removals

There are a lot of different volume types depending on the service where the project will be (AWS, Micrsoft...)

## Project

- Create repository in docker hub `kub-data-demo`
- `docker build -t gabrielcmoris/kub-data-demo .`
- `docker push gabrielcmoris/kub-data-demo`
- `kubectl apply -f kubernetes.yaml`
- `minikube service story-service` // From the metadata of Service in kubernetes.yaml
