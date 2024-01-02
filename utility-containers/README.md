## What are utility Containers

Containers that serve a specific purpose or provide utilities rather than running a specific application. These containers are designed to perform tasks such as system administration, monitoring, debugging, or providing specific services to other containers in the Docker ecosystem.

Some examples of utility containers include:

    - BusyBox: A lightweight container that includes stripped-down versions of common UNIX utilities, useful for debugging and troubleshooting.

    - Alpine Linux: A minimalistic Linux distribution container that is commonly used as a base image for other Docker containers due to its small size and security features.

    - Networking Tools: Containers that contain network diagnostic tools like ping, netstat, traceroute, etc., helpful in diagnosing networking issues within Docker environments.

    - Monitoring and Logging Tools: Containers preloaded with monitoring or logging tools like Prometheus, Grafana, ELK stack (Elasticsearch, Logstash, Kibana), etc., used for observing and analyzing containerized applications.

    - Backup and Recovery Tools: Containers equipped with backup and recovery utilities, allowing users to create backups of their Docker volumes or containers.

## Examples

`docker run -it node`
After this command I can use node commands. But How could I do it in detached mode??

`docker run -it -d node`

I will need to use this command to execute node commands
`docker exec <node cont. name> <command>`

## Run the Dockerfile of this utility container

1. Create image
   `docker build -t node-util .`
2. Run container
   `docker run -it -v /home/moris/learning/docker/utility-containers:/app node-util npm init`
