FROM debian:bullseye

RUN apt-get update -y 
RUN apt-get install -y nginx
RUN apt-get install -y curl
RUN mkdir -p /etc/nginx/ssl
RUN apt-get install -y openssl

# generate self-sign ssl/tls certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=caboudar.42.fr/UID=caboudar"
# RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=caboudar.42.fr"

RUN mkdir -p /var/run/nginx
# configuration file emplacement by default inside the container -> /etc/nginx/nginx.conf
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# to grant full access to the owner and allow nginx to write and execute the code, contains the static assets ... to run your web application
RUN chmod 755 /var/www/html
# www-data user and group are used for running web servers
# www-data user and group can now execute the files
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]