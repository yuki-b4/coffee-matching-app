# /bin/bash

if [ $# -eq 0 ];then
    echo "Argument error"
    echo "Pass the password"
    exit 0
fi
PASSWORD=$1
touch .env
touch ./graphql/.env
echo "DB_PASSWORD=${PASSWORD}" > .env
echo "DATABASE_URL=\"mysql://root:${PASSWORD}@db:3306/coffee\"" > ./graphql/.env
docker-compose build
docker-compose run front yarn
docker-compose run graphql yarn
docker-compose run graphql npx prisma generate
docker-compose run graphql npx prisma migrate dev --name init
docker-compsoe down
docker-compose up -d
