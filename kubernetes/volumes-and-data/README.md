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

## Type of volumes

### emptyDir:

It is a basic Volume, but when I have several replicas the second replica doesn't have access to the volumen because it is inside of each POD

### hostPath:

It creates a directory on the host machine where all pods and containers **on the same nod** have access

### CSI

A very flexible volume type. It depends on if the service (for example AWS) has the drivers.
