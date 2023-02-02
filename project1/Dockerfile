# Chose the image that we need from Docker hub for environment
FROM node

#BEFORE I copy the directory to the Image I choose WHERE I run the commands later (Absolute path)
WORKDIR /image

# copy everything in the path od Docker file to the pat in /image
# If I write COPY . ./ Docker will know the second path points to /image, I keep like this because it is more understandable
COPY . /image

# Command to install the dependencies into the image
RUN npm install

#Command to expose the port to our local system
# EXPOSE 80 in the Dockerfile in the end is optional. It documents that a process in the container will expose this port.
# This line is to document that the command should be > docker run -p 3000:80 <image id generated in build>
EXPOSE 80

#Command  to run the server If I use RUN node server.js it would use the node.js from code. Using CMD I will use the node.js from /image
# This is aldo possible ---> CMD node server.js
#This is always the last instruction
CMD ["node","server.js"]

# After this in command Line:
# > docker build .
# docker run -p [local port]:[container expose port] <image id generated in build>
# > docker run -p 3000:80 <image id generated in build>