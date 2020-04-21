docker_php = test_ci3_php-fpm_1
docker_nginx = test_ci3_nginx_1
docker_mysql = test_ci3_mysql_1

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