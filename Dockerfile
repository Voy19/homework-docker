FROM node:16.7.0 as build
WORKDIR /src
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
ARG PORT
RUN echo $PORT

FROM nginx
COPY --from=build /src/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
EXPOSE 8000
