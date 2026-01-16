SHELL=/bin/sh



ifndef COMPOSE_PROJECT_NAME
	include .env
	ifneq ("$(wildcard .env.local)","")
		include .env.local
	endif
endif



APP=${COMPOSE_PROJECT_NAME}.traefik.main
USER=www-data



# Docker:
logs:
	docker --log-level debug compose logs -f --tail 24
up:
	docker --log-level debug compose up -d --force-recreate
ps:
	docker --log-level debug compose ps
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
	docker --log-level debug compose ls -a



re-fresh: clean fresh
clean:
	docker --log-level debug compose down -v --rmi all --remove-orphans
fresh:
	docker --log-level debug compose build --no-cache --pull
	docker --log-level debug compose up -d --force-recreate



add-docker-network:
	docker network create ${COMPOSE_PROJECT_NAME}-traefik-network
remove-docker-network:
	docker network rm ${COMPOSE_PROJECT_NAME}-traefik-network
ls-docker-network:
	docker network ls --format table --no-trunc



app:
	docker exec -it $(APP) $(SHELL)
app-root:
	docker exec -it -u root $(APP) $(SHELL)
app-none-root:
	docker exec -it -u $(USER) $(APP) $(SHELL)
