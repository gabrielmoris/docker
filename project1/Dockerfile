# Because the image has layer based architecture and caches every command.
# If I modifuy the code of the app, would run all commands from there. That is why this Image can be optimized:


# Chose the image that we need from Docker hub for environment
FROM node

WORKDIR /image
# First I copy only the package JSON

COPY package.json /image
# Then I Install the dependencies
RUN npm install

# I copy the rest of the App.
COPY . /image

EXPOSE 80

CMD ["node","server.js"]

# After this in command Line:
# > docker build .
# docker run -p [local port]:[container expose port] <image id generated in build>
# > docker run -p 3000:80 <image id generated in build>