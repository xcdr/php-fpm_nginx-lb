FROM nginx:alpine

COPY ./conf/default.conf  /etc/nginx/conf.d/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
