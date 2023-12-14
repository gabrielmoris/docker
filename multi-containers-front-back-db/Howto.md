# Initialize Mongo DB

`docker run --name mongodb --rm -d -p 27017:27017 mongo`

# Create Images

### Backend

`docker build -t goals-node .`

In the mongoose connect We have to listen `'mongodb://host.docker.internal:27017/course-goals',` since localhost is isolated

### Frontend

`docker build -t goals-react .`

# Run Containers Isolated but connetcet

### Backend

`docker run --name goals-backend --rm -d -p 80:80 goals-node`

### Frontend

"Run the image and put the name goals-frontend, remove when it is finished, do it in detached mode and expose the port 3000 to the port 3000 and do it in interactive mode (necessary for webapps)"

`docker run --name goals-frontend --rm -d -p 3000:3000 -it goals-react`

# Run Containers In network

In the Backend, in mongoose connect We have to listen `"mongodb://mongodb:27017/course-goals"` since we are in the same network
The backend still needs to expose and the frontend doesn't need to be in network

```
    docker network create goals-net
    docker run --name mongodb --rm -d --network goals-net mongo
    docker run --name goals-backend --rm -d -p 80:80 --network goals-net goals-node
    docker run --name goals-frontend --rm -d -p 3000:3000 -it goals-react
```
