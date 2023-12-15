# Initialize Mongo DB

with the command `-v data:/data/db` I create a volume where data persists after container is stopped
`docker run --name mongodb -v data:/data/db --rm -d -p 27017:27017 mongo`

# Build Images

### Backend

`docker build -t goals-node .`

In the mongoose connect We have to listen `'mongodb://host.docker.internal:27017/course-goals',` since localhost is isolated

### Frontend

`docker build -t goals-react .`

# Run Containers Isolated but connected

### Database

`docker run --name mongodb -v data:/data/db --rm -d -p 27017:27017 mongo`

### Backend

`docker run --name goals-backend --rm -d -p 80:80 goals-node`

### Frontend

"Run the image and put the name goals-frontend, remove when it is finished, do it in detached mode and expose the port 3000 to the port 3000 and do it in interactive mode (necessary for webapps)"

`docker run --name goals-frontend --rm -d -p 3000:3000 -it goals-react`

# Run Containers In network

In the Backend, in mongoose connect We have to listen `"mongodb://mongodb:27017/course-goals"` since we are in the same network.
The backend has 3 volumes:

1.  Pointing to the code so It will have live source code update
2.  Other for the app logs called logs
3.  An anonymouse volume for the node_modules to dont overwrite the node modules in the app

The backend still needs to expose and the frontend doesn't need to be in network.
With the command `-e MONGO_INITDB_ROOT_USERNAME=gabriel -e MONGO_INITDB_ROOT_PASSWORD=secret`, I add password to the mongodb. That will require changes in my app.js `mongodb://gabriel:secret@mongodb:27017/course-goals?authSource=admin`, I can make ENV variables and declare them in Dockerfile as well

```
    docker network create goals-net

    docker run --name mongodb -v data:/data/db --rm -d --network goals-net  -e MONGO_INITDB_ROOT_USERNAME=gabriel -e MONGO_INITDB_ROOT_PASSWORD=secret mongo

    docker run --name goals-backend -v /home/moris/learning/docker/multi-containers-front-back-db/backend:/app -v logs:/app/logs -v /app/node_modules --rm -d -p 80:80 --network goals-net goals-node

    docker run --name goals-frontend -v /home/moris/learning/docker/multi-containers-front-back-db/frontend/src:/app/src --rm -d -p 3000:3000 -it goals-react
```

# Run Containers with docker compose

- To start in detached mode `docker compose up -d`
- To stop and delete volumes `docker compose down -v`
- To start and force build `docker compose up --build`
- To just build only the images `docker compose build`
