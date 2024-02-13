

all: 
	mkdir -p /home/caboudar/data/mariadb
	mkdir -p /home/caboudar/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up --build -d

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx

clean:
	docker compose -f ./srcs/docker-compose.yml down;

fclean: clean
	sudo rm -rf /home/caboudar/data/mariadb/*
	sudo rm -rf /home/caboudar/data/wordpress/*
	-docker system prune -af

re: fclean all

.Phony: all logs clean fclean
