FROM klakegg/hugo:0.87.0-ext-alpine AS hugo
RUN apk add -U git
COPY --from=golang:1.13-alpine /usr/local/go/ /usr/local/go/
 
ENV PATH="/usr/local/go/bin:${PATH}"
COPY . /src
COPY config.toml.local /src/config.toml
# RUN make init
RUN make build

FROM nginxinc/nginx-unprivileged
COPY nginx/nginx-app.conf /etc/nginx/conf.d/
COPY nginx/nginx-prod.conf /etc/nginx/nginx.conf
COPY --from=hugo /src/public /usr/share/nginx/html