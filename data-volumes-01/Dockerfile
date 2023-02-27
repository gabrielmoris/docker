FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

# If i use bind mount I dont need to copy but It is neccesary for Production
COPY . .

# Creates a persistent ANONYMOUSE file in our local machine to store the files in the containet /app/feedback
# docker volume ls
# VOLUME [ "/app/feedback" ]
# INSTEAD I will create a named volume inside of the run command adding: -v feedback:/app/feedback
# To remove: docker volume rm VOL_NAME

# This argument can be used here, for example in the .env
ARG DEFAULT_PORT=80

# Here I create an enviromnmental variable and I assign it in EXPOSE. This variable is accesible on the entire app code via process.env.PORT
ENV PORT $DEFAULT_PORT

EXPOSE $PORT
# Here I am creating a detached app that has a Volume named feedback that will be bounded to the actual app and a anonnymouse volume 
# that is bounded to node_modules. Both volumes will coexist. The reason is that the volume shouldn´t write in my local machine, that is why I need 2 different volumes.


# If I want too use a Bind Mounts (to check the image)

# for this I must add an anonymous volume with the node modules or make it in the command
# VOLUME ["/app/node_modules"]

# CREATE IMAGE
# docker build -t feedback-node:volumes 

# RUN CAONTAINER                                                                            /:ro =readonly\
# docker run -p 3000:80 -d --rm --name feedback-app -v feedback:/app/feedback -v $(pwd):/app:ro -v app/temp -v /app/node_modules feedback-node:volumes
#                       \_/ dettached mode            \_ named volume uploads_/ \_N. V. app_/  \anon tep volume/ \_N. V. node_modules_/ \_image_/

CMD ["npm","start"]
