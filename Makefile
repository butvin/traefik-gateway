SHELL=/bin/sh



ifndef COMPOSE_PROJECT_NAME
	include .env
	ifneq ("$(wildcard .env.local)","")
		include .env.local
	endif
endif



APP=${COMPOSE_PROJECT_NAME}.traefik
USER=www-data



# Docker:
logs:
	@docker compose logs -f --tail 24
up:
	@docker compose up -d --force-recreate
ps:
	@docker compose ps
restart:
	@docker compose restart
stop:
	@docker compose stop
images:
	@docker compose images
start:
	@docker compose start
down:
	@docker compose down
top:
	@docker compose top
kill:
	@docker compose kill
ls:
	@docker compose ls -a




re-fresh: clean fresh
clean:
	docker -D compose down -v --rmi local --remove-orphans
fresh:
	docker -D compose build --no-cache --progress=plain
	docker -D compose up -d --force-recreate




add-docker-network:
	docker network create ${COMPOSE_PROJECT_NAME}-traefik-network





app:
	docker exec -it $(APP) $(SHELL)
app-root:
	docker exec -it -u root $(APP) $(SHELL)
app-none-root:
	docker exec -it -u $(USER) $(APP) $(SHELL)
