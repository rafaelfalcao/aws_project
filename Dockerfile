FROM 639110431478.dkr.ecr.eu-west-2.amazonaws.com/nginx:latest
COPY public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]