FROM node:14-alpine

# In Linux, by default Docker runs as the "Root" user, so when we do a lot of the things that you are advocating for with Utility Containers the files that get written to the Bind Mount have ownership and permissions of the Linux Root user.
# The Official Node.js Docker Container provides such a user that they call "node". 
# https://github.com/nodejs/docker-node/blob/master/Dockerfile-slim.template
USER node

WORKDIR /app

ENTRYPOINT [ "npm" ]