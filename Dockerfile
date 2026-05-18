# build
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

ARG VITE_API_URL
ENV VITE_API_URL=$VITE_API_URL

RUN npm run build

# runtime (no-root)
FROM nginxinc/nginx-unprivileged:stable-alpine

COPY templates/ /etc/nginx/templates/

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080