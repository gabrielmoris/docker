# Main notes

- In Prod I dont need Volumes to do bind-mounts.

## Deployment (do it yourself Approach) with AWS EC2.

I can do it in 3 simple steps:

### 1. Create and launch EC2 Instance, VCP and security group

    a) go to amazon EC2 and click on Launch Instance
    b) select a free tier like Amazon Linux 2 AMI SSD Volume type
    c) make sure that in network there is a vpc or create a new one
    d) create a new key pair and click on next (Download it)

### 2. Connect to instance (SSH), install Docker and run container

    a) Go to Instances and click in connect in the selected instance
    b) go to the tab ssh and follow the instructions with the key you downloaded (in WSL or PUTTY)
    c) Install Docker:

```bash
sudo yum update -y

sudo yum -y install docker

sudo service docker start

sudo usermod -a -G docker ec2-user

# Make sure to log out + back in after running these commands.
# Once you logged back in, run this command:

sudo systemctl enable docker
docker version
```

    d) I Upload the image in docker hub to use it later in the ec2 instance instead of uploading and building in the ec2 to avoid complexities.
        - Create the repository.
        - Build the image with `docker build -t docker-example-1 .`
        - Log in the console with docker `docker login`
        - Tag the image with the same name as the docker hub repository: `docker tag docker-example-1 gabrielcmoris/docker-leanrirng-example-1`
        - Push the image to docker hub `docker push gabrielcmoris/docker-leanrirng-example-1`
        - Log in the EC2 instance and run the image `docker run -d --rm -p 80:80 gabrielcmoris/docker-leanrirng-example-1`

### 3. Configure Security group to expose all required ports to WWW

    a) Back in aws in instances I can see the ipv4 to reach the app. But still is not public, In the tab of the left I can go to "Security groups" and there I can see the security group created with my instance and the other ones I have.
    b) I click on the security group of the instance. I click on edit the Inbound rules.
    c) I add a new rule: Type: http, Source: Anywhere and save. Copu the ipv4 of the instance and paste it on the browser.

NOTE: To update the app I make the changes locally, I reupload to docker hub, and In the ec2 container I stop and rebuild the image.

## Deployment only 1 container with a Managed Remote Machine with AWS ECS.

- This approach doesnt use docker, but a container service with his own rules.
  a) Go to the aws ECS service (It has not free tier)
  b) Click on create custom.
- In Image we write the Image I uploaded to docker hub: `gabrielcmoris/docker-leanrirng-example-1`.
- In Port mappings I specify 80 (equivalent to `-p 80:80`).
- click on update and next.

NOTE: To update the app I make the changes locally, I reupload to docker hub, go to AWS ECS < clusters < default < tasks and click in "create new revision". Click on actions < "Update service" and after thet "skip to review" and "update service".

## Deployment multiple containers with a Managed Remote Machine with AWS ECS.

1. Prepare the container and upload it to docker hub

- We have to make a change in the docker connection endpoint for ECS:
  `mongodb://${process.env.MONGODB_USERNAME}:${process.env.MONGODB_PASSWORD}@mongodb:27017/course-goals?authSource=admin`
  should be changed to:
  `mongodb://${process.env.MONGODB_USERNAME}:${process.env.MONGODB_PASSWORD}@${process.env.MONGODB_URL}:27017/course-goals?authSource=admin`
  , add in the /env/backend.env `MONGODB_URL=mongodb`, and in the backend Dockerfile `ENV MONGODB_URL=mongodb`
- Build the image `docker build -t goals-node ./backend`
- Create new repository in docker hub, tag the image `docker tag goals-node gabrielcmoris/goals-node` and push the image `docker push  gabrielcmoris/goals-node`

2. Create ECS Cluster with 2 images (Mongo and Backend)

- In amazon ECS click in "create a new cluster" and give a name
- Click in create new VPC to have a private cloud for this cluster and wait
- Click on view cluster and click in the tab tasks. Create a new task definition. Name it and give it the role of `ecsTaskExecutionRole`.

  a) Add Backend Image from Docker Hub

  - Click in "Add Container" and name it for example "goals". and in image use the docker hub image: `gabrielcmoris/goals-node`. Port Mappings `80`. In Command `node,app.js`
  - Specify the ENV variables from the backend.env. For the MONGODB_URL we use `localhost` instead of mongodb.
  - Click Add

  b) Add MongoDb Image

  - Click in "Add Container". Give name, choose the image `mongo` from Docker hub official image, choose port `27017` (the Oficial default for mongodb.)
  - Specify the ENV variables from the mongo.env. `MONGO_INITDB_ROOT_USERNAME=max` `MONGO_INITDB_ROOT_PASSWORD=secret`
  - Click Add
  - Click in Create

3. Launch the service

- Go to clusters > goals-app > in Services click "create":

  - Choose Fargate
  - Choose goals in Task Definiton
  - Service name "goals-service"
  - Number of tasks: 1
  - click "Next Step"
  - Choose the cluster VPC and the subnets
  - Auto-assign public IP should be ENABLED
  - Load balancer type : Application Load Balancer
  - **Create Load Balancer**

    - Choose create application load balancer. Name it. Export in port 80. Choose the same VPC as the cluster.
    - Click on configure security groups. Select an existing security group and choose the default VPC security group
    - Choose a new target group. Name it. choose Target type: IP.
    - Click "Register Targets", "Review" and then "Create"

  - Choose the load balancer I created and the container name :port and click in "Add to load balancer"
  - Click "Next step" and "Next step" again and afterwards "Create Service"

4. See the public IP

- Go to clusters > goals-app > services and click in goals-service
- Click in tab Tasks and in the task. There I have the public IP
  If there Is an error :

  - Go to Target Groups Edit the Healt Check Settings and in path write /goals
  - Go to Load Balancer > Edit security groups and add the goals as well

- The service would be successful created in \<IP>\/goals

5. Update the service

- Upload the new version to docker hub
- Go to cluster:goals-app
- Click in goals-service. Click "Update" in top right
- check force Deployment. Click "Skip to review"

6. Add Volume for persistent Data

- Go to amazon ECS > task definitions > click on goals and pick the latest
- Click on create new revision. Scroll wown and click on add volume. Add Name, type EFS, click on Amazon EFS console to create a file system
  - Click on create file system. Name it. Use the same VPC as before. Click in "Customize"
  - In step 2 "Network access". I wait meanwhile I go to security ggroups and I create a new security group. Name it, for example "efs-sc". Same VPC as always. Click on add Inbound ruule > Choose `NFS`. in Source > `Custom` and choose the same security group I use in the containers. Click on "Create"
  - Back in "Network access" I choose the security group I created for the Mount Targets
  - Click "next" all the time and then "Create"
- Back on new revision I choose the file system I created. Click "Add"
- Go to up and choose the container mongodb. Scroll to STORAGE AND LOGGING and in Mount points choose the one I created an path \<container name \>/db
- Click update and Create. Then in "Actions" I choose "Update Service", I check the Force New Deployment, "Skip to review" and "Update Service"

7. It would be more covenient in production if we use Mongo Atlas instead of another container

- Build a new cluster
- Connect to the new container in `/backend/app.js` using from monto the connection endpoint: `mongodb+srv://{process.env.MONGODB_USERNAME}:${process.env.MONGODB_PASSWORD}@$${process.env.MONGODB_URL}/${process.env.MONGODB_DATABASE}?retryWrites=true&w=majority`
- Delete the mongo container, the depends_on mongodb, and the volumes in docker-compose
- Go in Mongo atlas to network address and allow access to the ip or to all
- Reupload the Image in docker hub. `docker build -t goals-node ./backend` `docker tag goals-node gabrielcmoris/goals-node` `docker push  gabrielcmoris/goals-node`
- delete the volume and the container of docker in ECS.
  - Click in Task Definitions > Goals > click in last Task definition > Create new revision
  - delete mongo container, volume, go to EFS and delete the EFS as well, go to EC2 > Security Groups > Delete the security group of the EFS
- Change the ENV. Click in container Goals-backend
- Accept, Click Actions > Update Service > check Force Deployment > Skip to review > Update Service
