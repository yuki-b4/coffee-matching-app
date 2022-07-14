# /bin/bash

# 作成中
if [ $# -eq 0 ]
    echo "Argument error"
    echo "Pass the password"
fi
PASSWORD=$1
touch .env
touch ./graphql/.env
echo "DB_PASSWOR = ${PASSWORD}" > .env
echo "DATABASE_URL=\"mysql://root:${PASSWORD}@db:3306/coffee\"" > ./graphql/.env
docker-compose build
docker-compose run front yarn
docker-compose run graphql yarn
docker-compsoe down
docker-compose up -d
