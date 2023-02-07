FROM node

WORKDIR /image

COPY package.json .

RUN npm install

COPY . .

EXPOSE 3000

CMD ["node","server.js"]

# After this in command Line:
# > docker build -t nodebasic:version0 .
# docker run -p [local port]:[container expose port] <image id generated in build>
# > docker run -p 3000:3000 --rm --name nodempty c0357e09a709<-- image id generated in build (example)