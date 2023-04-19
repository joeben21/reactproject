FROM ubuntu AS builder

WORKDIR /app
COPY . .

RUN apt update -y
RUN apt install -y npm
RUN npm install
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]

EXPOSE 80
