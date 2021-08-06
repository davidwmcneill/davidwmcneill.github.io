FROM klakegg/hugo:0.78.2-alpine AS hugo
RUN apk add -U git
COPY . /src
# RUN make init
RUN make build

FROM nginxinc/nginx-unprivileged
COPY nginx/nginx-app.conf /etc/nginx/conf.d/
COPY nginx/nginx-prod.conf /etc/nginx/nginx.conf
COPY --from=hugo /src/public /usr/share/nginx/html