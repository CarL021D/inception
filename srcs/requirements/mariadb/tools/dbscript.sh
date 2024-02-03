#!/bin/bash
if [ -e "/var/lib/mysql/first_config_db_done" ]
then
	echo "Database already configured"
else
	echo "Creating the files change_root.sql and config_db.sql"
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';" >> /var/lib/mysql/change_root.sql
	echo "FLUSH PRIVILEGES;" >> /var/lib/mysql/change_root.sql
	echo "CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';" > /var/lib/mysql/config_db.sql
	echo "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;" >> /var/lib/mysql/config_db.sql
	echo "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';"  >> /var/lib/mysql/config_db.sql
	echo "FLUSH PRIVILEGES;" >> /var/lib/mysql/config_db.sql

	service mariadb start

	sleep 5

	# Configuring MYSQL
	mariadb -u root < /var/lib/mysql/config_db.sql

	#Changing root password
	mariadb -u root < /var/lib/mysql/change_root.sql

	#Shuting down the database
	mariadb-admin --user=root --password=$MARIADB_ROOT_PASSWORD shutdown

	#Removing temporary files
	rm /var/lib/mysql/change_root.sql /var/lib/mysql/config_db.sql

	#Creating first_config_db_done
	touch /var/lib/mysql/first_config_db_done
fi

#Launching mysql_safe service
exec mysqld_safe;





#!/bin/bash
#service mysql start;

#mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
#mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
#mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
#mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
#mysql -e "FLUSH PRIVILEGES;"

#mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
#exec mysqld_safe
