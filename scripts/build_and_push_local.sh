#!/bin/bash

# Iniciar sesión en Docker Hub
echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

# Construir y etiquetar las imágenes
docker build -t "$DOCKERHUB_USERNAME/$DOCKERHUB_REPO:server-latest" ./server
docker build -t "$DOCKERHUB_USERNAME/$DOCKERHUB_REPO:client-latest" ./client
docker build -t "$DOCKERHUB_USERNAME/$DOCKERHUB_REPO:web-latest" ./web

# Subir las imágenes a Docker Hub
docker push "$DOCKERHUB_USERNAME/$DOCKERHUB_REPO:server-latest"
docker push "$DOCKERHUB_USERNAME/$DOCKERHUB_REPO:client-latest"
docker push "$DOCKERHUB_USERNAME/$DOCKERHUB_REPO:web-latest"

docker pull "$DOCKERHUB_USERNAME/$DOCKERHUB_REPO:server-latest"
docker pull "$DOCKERHUB_USERNAME/$DOCKERHUB_REPO:client-latest"
docker pull "$DOCKERHUB_USERNAME/$DOCKERHUB_REPO:web-latest"

docker run -d --name api --restart always -p 3000:3000 --network npm -e NODE_ENV=production -e DB_HOST=mysql -e DB_PORT=3306 -e WEB_PORT="3000" -e MYSQL_USER=root -e MYSQL_PASSWORD=$DB_PASSWORD -e MYSQL_DATABASE="blackzone" -e VIRTUAL_HOST="api.blackzone.mx" -e LETSENCRYPT_HOST="api.blackzone.mx"  "$DOCKERHUB_USERNAME/$DOCKERHUB_REPO:server-latest"
docker run -d --name client --restart always -p 8080:80 --network npm -e VIRTUAL_HOST="admin.blackzone.mx" -e LETSENCRYPT_HOST="admin.blackzone.mx" "$DOCKERHUB_USERNAME/$DOCKERHUB_REPO:client-latest"
docker run -d --name web --restart always -p 8081:80 --network npm -e VIRTUAL_HOST="blackzone.mx" -e LETSENCRYPT_HOST="blackzone.mx" "$DOCKERHUB_USERNAME/$DOCKERHUB_REPO:web-latest"
