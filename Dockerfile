FROM node:18
MAINTAINER Diego Zazueta <diego.zazueta@coppel.com>

RUN mkdir /home/app

COPY ["package.json", "package-lock.json", "/home/app"]

WORKDIR /home/app

RUN npm install

COPY . /home/app

CMD npm run dev
