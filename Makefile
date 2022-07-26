prisma-studio:
	docker-compose exec graphql npx prisma studio
migrate:
	docker-compose exec graphql npx prisma migrate dev
up:
	docker-compose up -d
stop:
	docker-compose stop