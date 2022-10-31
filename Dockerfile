FROM node:18
MAINTAINER Diego Zazueta <diego.zazueta@coppel.com>

#Agregamos package.json a un directorio que funge como temporal
#a menos que las dependencias se modifiquen no volveran a bajarlas y se ejecuta la instalacion de deps node del proyecto
RUN mkdir /home/app

COPY ["package.json", "package-lock.json", "/home/app"]

WORKDIR /home/app

RUN npm install

COPY . /home/app

EXPOSE 2000

CMD npm run dev
