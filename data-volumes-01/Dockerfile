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


# If I want too use a Bind Mounts (to check the image)
# docker run -p 3000:80 -d --rm --name feedback-app -v feedback:/app/feedback -v $(pwd):/app feedback-node
# for this I must add an anonymousse volume with the node modules or make it in the command
# VOLUME ["/app/node_modules"]

# CREATE IMAGE
# docker build -t feedback-node:volumes 

# RUN CAONTAINER
# docker run -p 3000:80 -d --rm --name feedback-app -v feedback:/app/feedback -v $(pwd):/app -v /app/node_modules feedback-node:volumes

CMD ["npm","start"]
