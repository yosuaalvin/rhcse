#bin/sh
sudo podman run -d --name wpweb --restart=always --pod wordpress -e WORDPRESS_DB_HOST="127.0.0.1" -e WORDPRESS_DB_USER=user1 -e WORDPRESS_DB_PASSWORD=mypa55 -e WORDPRESS_DB_NAME=wordpress docker.io/library/wordpress
