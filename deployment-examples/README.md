# Main notes

- In Prod I dont need Volumes to do bind-mounts.

## Deployment-01-starting-setup (do it yourself Approach).

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