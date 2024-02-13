FROM	debian:bullseye

LABEL	author="caboudar"
LABEL	version="1.0"

RUN		mkdir -p /var/lib/mysql

RUN		apt update -y
RUN		apt upgrade -y
RUN		apt install mariadb-server -y

EXPOSE	3306

COPY 	conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY 	tools/mariadb.sh	mariadb.sh
RUN		chmod +x mariadb.sh

CMD		["./mariadb.sh"]
