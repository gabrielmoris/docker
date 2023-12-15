FROM node

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 80

# Not needed if declared in docker-compose
# ENV MONGODB_USERNAME=gabriel
# ENV MONGODB_PASSWORD=secret

CMD ["npm","start"]