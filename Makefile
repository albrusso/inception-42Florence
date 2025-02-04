# Makefile
all: up

up:
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down

clean:
	docker system prune -af

destroy:
	docker volume rm $(docker volume ls -q)
