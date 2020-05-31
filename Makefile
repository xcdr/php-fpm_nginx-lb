docker-build: docker_nginx docker_php-fpm

docker_nginx:
	docker build --rm -t xcdr/php-fpm_nginx-lb_nginx nginx/

docker_php-fpm:
	docker build --rm -t xcdr/php-fpm_nginx-lb_php-fpm php-fpm/

docker-push: docker-build
	docker push xcdr/php-fpm_nginx-lb_nginx
	docker push xcdr/php-fpm_nginx-lb_php-fpm

clean:
	docker rmi xcdr/php-fpm_nginx-lb_nginx

