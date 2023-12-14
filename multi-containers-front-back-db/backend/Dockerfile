FROM node

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 80

ENV MONGODB_USERNAME=gabriel
ENV MONGODB_PASSWORD=secret

CMD ["npm","start"]