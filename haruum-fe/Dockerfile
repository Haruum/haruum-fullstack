FROM node:16.14.2-slim AS build
ENV REACT_APP_GATEWAY_URL="REACT_APP_GATEWAY_URL_PLACEHOLDER"
WORKDIR /app
COPY ./haruum-fe .
RUN npm config set registry http://registry.npmjs.org/ && \
    npm install && \
    npm run build

FROM nginx
COPY --from=build /app/build /var/www/html
RUN sed -i 's/usr\/share\/nginx\/html/var\/www\/html/g' /etc/nginx/conf.d/default.conf
ENTRYPOINT sed -i "s/REACT_APP_GATEWAY_URL_PLACEHOLDER/$REACT_APP_GATEWAY_URL/g" /var/www/html/index.html && nginx -g "daemon off;"
