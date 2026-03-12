# Step 1: Build React app
FROM node:18 as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


# Step 2: Serve using Nginx
FROM ubuntu:22.04

RUN apt update && apt install -y nginx

COPY --from=build /app/build /var/www/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]