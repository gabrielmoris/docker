FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

# Creates a persistent ANONYMOUSE file in our local machine to store the files in the containet /app/feedback
# docker volume ls
# VOLUME [ "/app/feedback" ]
# INSTEAD I will create a named volume inside of the run command adding: -v feedback:/app/feedback
# To remove: docker volume rm VOL_NAME

EXPOSE 80
# Here I am creating a detached app that has a Volume named feedback that will be bounded to the actual app and a anonnymouse volume 
# that is bounded to node_modules. Both volumes will coexist. The reason is that the volume shouldn´t write in my local machine, that is why I need 2 different volumes.

# docker run -d -p 3000:80 --name feedback-app --rm -v feedback:/app/feedback -v $(pwd):/app -v /app/node_modules feedback-node
#            \_/ dettached mode                      \_ named volume uploads_/ \_N. V. app_/  \_N. V. node_modules_/ \_image_/
CMD ["node","server.js"]
