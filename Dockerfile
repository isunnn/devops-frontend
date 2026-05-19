# build
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

ARG VITE_API_URL
ENV VITE_API_URL=$VITE_API_URL

RUN npm run build

FROM nginxinc/nginx-unprivileged:stable-alpine

COPY templates/ /etc/nginx/templates/

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080

#comentario para hacer push a deploy branch, saludos!