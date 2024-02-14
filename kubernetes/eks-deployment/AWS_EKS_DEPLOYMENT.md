With Kubernetes I will still have to take care of the infraestructure.

### Using ECS

I can make a instance, install the software with tools like [kops](https://github.com/kubernetes/kops)

### Using Manage Service

It is a managed service for Kubernetes deployments

# Using EKS

### Create the cluster

- Straightforward: Name, version... In Service Role: **I have to create a new role**
  - Search in IAM console > Create Role > EKS > EKS cluster. Just give some name.
- Select role and then I have too create the **Networks**
  - Search cloudFormation > Create Stack > [copy the url from this Doc](https://docs.aws.amazon.com/eks/latest/userguide/creating-a-vpc.html#create-vpc) and paste it in Amazon S3 URL > click next until I can create
- Select the network and In cluster Endpoint access choose Public and private. Click next and then create.

- There is a file that allows kubectl to talk to minikube. This file is in `/.kube/config`. I have to modify it to make it able to talk with AWS. Better save a copy of it first and then I can install the amazon cli. To use it, I have to go to AWS, click in my name > security credentials > Access KEys > Create one. Then download the key to use it.
- In console run: `aws configure` and use the downloaded credentials and the region.
- run the command `aws eks --region <region> update-kubeconfig --name <name I gave to the cluster>`. It will update the `/.kube/config` file

### Add worker nodes

- Go to Cluster > computed secrion > add node group
- Give a Name, inn **Iam role**
  - Open IAM cnsole, create role > EC2 > add permisions (EKSworker,cni,ec2containerregistryreadonly),name and save
- Pick the new group. In step 2 keep everything. I can disable in next step the remote access to the nodes. create.

### Apply kubernetes config

- In the console I can run exactly how I did with Minikube `kubectl apply -f auth.yaml -f users.yaml` (images should be pushed in docker hub)

### add Volumes

- I need to run in my kubernetes (conected in aws) the command from this [Docummentation](https://github.com/kubernetes-sigs/aws-efs-csi-driver) `kubectl apply -k "github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.0"`
- Create a EFS in AWS:
  - For that first I go to EC2 > Security gropues > create > choose in VPC the eksVpc I have >add inbound rule (NFS, custom, copy the IP from the eksVPC)
  - Create and choose the eksVPC > customice Z In Network access delete the security groups and use the ones I choose > create. Copy the filesystemID
- create the persistent volume in users

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: efs-sc
provisioner: efs.csi.aws.com
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: efs-pv
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  storageClassName: efs-sc
  csi:
    driver: efs.csi.aws.com
    volumeHandle: <filesystem ID from AWS>
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: efs-pvc
spec:
  accessModes: -ReadWriteMany
  storageClassName: efs-sc
  resources:
    requests:
      storage: 5Gi
---
```

- In the user deployment also add the claim volume:

```yaml
volumeMounts:
  - name: efs-vol
    mountPath: /app/users
```

```yaml
volumes:
  - name: efs-vol
    persistentVolumeClaim:
      claimName: efs-pvc
```

- With the command `kubectl get services` I can see the external IP from AWS
