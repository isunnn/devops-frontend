# build
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# runtime (no-root)
FROM nginxinc/nginx-unprivileged:stable-alpine

COPY templates/ /etc/nginx/templates/

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080