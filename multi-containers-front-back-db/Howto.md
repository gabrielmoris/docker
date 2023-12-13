# Initialize Mongo DB

`docker run --name mongodb --rm -d -p 27017:27017 mongo`

# Create Images

## Backend

`docker build -t goals-node .`

# Run Containers

## Backend

`docker run --name goals-backend --rm -d -p 80:80 goals-node`
