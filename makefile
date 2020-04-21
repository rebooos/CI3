docker_php = ci3_php-fpm_1
docker_nginx = ci3_nginx_1
docker_mysql = ci3_mysql_1

#some commands
start: 
	@docker-compose up -d

stop: 
	@docker-compose stop

show_containers: 
	@docker ps

connect_php: 
	@docker exec -it $(docker_php) bash

connect_nginx: 
	@docker exec -it $(docker_nginx) bash

connect_mysql: 
	@docker exec -it $(docker_mysql) bash

dump_up:
    cat mysql-dump/dump_test_task.sql |  docker exec -i ci3_mysql_1 mysql -u root --password=root test_task