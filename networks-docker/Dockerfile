FROM node

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

CMD ["node", "app.js"]

# __________MANUAL WAY_________________
#  get mongo img and run it
# docker run -d --name mongodb mongo
# inspect mongo container
# docker container inspect mongodb
# Copy "IPAddress"
# Paste it in app.js in the mongo connection instead of localhost

# Build the img
# docker build -t favourites-node .
# Run container
# docker run --name favourites -d --rm -p 3000:3000  favourites-node

# __________NETWORKED WAY_________________
# 1.create a network
# docker network create favorites-net
# 2. run the mongo container
# docker run -d --name mongodb --network favorites-net mongo
# 3. in app.js instead of localhost I use the name of the mongo container {"mongodb://mongodb:27017/swfavorites",}
# 4. build the app image
# docker build -t favourites-node .
# 5. run the container
# docker run --name favourites --network favorites-net -d --rm -p 3000:3000  favourites-node
