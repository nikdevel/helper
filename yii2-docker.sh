#!/usr/bin/env bash

# Install docker
apt update
apt upgrade
apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
apt update
apt-cache policy docker-ce
apt install docker-ce --no-install-recommends



git clone https://github.com/yiisoft/yii2-docker.git yii2-docker
cd yii2-docker

cp .env-dist .env
docker-compose build


docker-compose up -d

docker-compose run --rm php php /tests/requirements.php
docker-compose run --rm php bash 

# In container
# composer create-project --prefer-dist yiisoft/yii2-app-basic /app

echo "Done!"
