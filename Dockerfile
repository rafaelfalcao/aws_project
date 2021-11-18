#base image
FROM node:13.12.0-alpine

#set working dir
WORKDIR /app

#add node modules/.bin to PATH
ENV PATH  /app/node_modules/.bin:$PATH

#install dependencies
COPY weather-app-indicator/package.json ./
COPY weather-app-indicator/package-lock.json ./
RUN npm install --silent
RUN npm install react-script@3.4.1 -g --silent
COPY . ./

EXPOSE 3000

CMD ["npm", "start"]