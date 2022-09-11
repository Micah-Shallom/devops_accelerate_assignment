FROM node:16-alpine3.15

EXPOSE 3000

RUN mkdir -p /home/app

COPY . /home/app

WORKDIR /home/app

RUN ["npm", "install"]

CMD ["npm" , "start"]