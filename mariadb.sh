#bin/sh
#bagian mysql
cat mypassword.txt | sudo podman login registry.redhat.io --username yosuaalvin90 --password-stdin
sudo podman pull registry.redhat.io/rhscl/mariadb-102-rhel7:1-66
mkdir -pv /home/student/mysql
sudo semanage fcontext -a -t container_file_t '/home/student/mysql(/.*)'
sudo restorecon -R /home/student/mysql
podman unshare chown 27:27 /home/student/mysql
#bagian wordpress
sudo podman pull docker.io/library/wordpress
sudo podman pod rm -f wordpress
sudo podman pod create --name wordpress -p 8080:80
sudo podman run -d --name wpdb --restart=always --pod wordpress -v /home/student/mysql/:/var/lib/mysql/data -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -e MYSQL_DATABASE=wordpress -e MYSQL_ROOT_PASSWORD=r00tpa55 registry.redhat.io/rhscl/mariadb-102-rhel7:1-66
