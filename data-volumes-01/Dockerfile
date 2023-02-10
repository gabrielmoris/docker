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

# docker run -p 3000:80 -d --rm --name feedback-app -v feedback:/app/feedback feedback-node
CMD ["node","server.js"]
