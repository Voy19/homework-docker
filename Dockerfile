FROM node:16.7.0 as build
WORKDIR /src
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# For deploying to heroku (comment 9, 10 rows if you don't need this)
ARG PORT
RUN echo $PORT

FROM nginx
COPY --from=build /src/build /usr/share/nginx/html

# For deploying to heroku (comment 16, 17 rows if you don't need this)
COPY nginx.conf /etc/nginx/conf.d/default.conf
CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'

EXPOSE 8001
