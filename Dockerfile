FROM node:18-buster-slim as build


ENV VITE_API_URL=https://api.blackzone.mx

WORKDIR /app
COPY . /app


RUN yarn install --silent
RUN yarn build

FROM ubuntu
RUN apt-get update
RUN apt-get install nginx -y
COPY --from=build /app/build /var/www/html/
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
