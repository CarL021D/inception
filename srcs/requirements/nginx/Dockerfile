FROM	debian:bullseye

LABEL	author="caboudar"
LABEL	version="1.0"

RUN apt-get update -y
RUN apt install -y nginx
RUN apt install -y curl
RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y

RUN		openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=caboudar.42.fr/UID=caboudar"

RUN		chmod 755 /var/www/html && \
		chown -R www-data:www-data /var/www/html

COPY	conf/nginx.conf /etc/nginx/nginx.conf

CMD		["nginx", "-g", "daemon off;"]
