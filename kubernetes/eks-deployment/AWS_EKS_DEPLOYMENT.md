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
