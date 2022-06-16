# syntax=docker/dockerfile:1

#specify my baseImage and (optionally) the version
FROM node:14.17.1 as base

# specify the source and destination paths
# ENV NODE_ENV = development

#specify the path of the working directory
# COPY . /app

WORKDIR /app

#copy package.json for dependency install
COPY package.json package.json
COPY package-lock.json package-lock.json

#specify test build
FROM base as test

#clean dependency install
RUN npm ci 

#copy files to image
COPY . .
#command to run tests
CMD [ "npm", "run", "test" ]

#specify test build
FROM base as prod 

RUN npm ci --production
#install the dependencies 
# RUN npm install

COPY . .
# expose the port in the docker container
EXPOSE 3000

#command to start our path
CMD ["npm", "start"]
