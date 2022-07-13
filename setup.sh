# 作成中

PASSWORD=$1
touch .env
echo "DB_PASSWOR = ${PASSWORD}" > .env
docker-compose build
docker-compose run front yarn
docker-compose run graphql yarn
docker-compose up -d