FROM node:16.7.0 as build
WORKDIR /src
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=build /src/build /usr/share/nginx/html

EXPOSE 8000
