default: build-nginx build-app

build-nginx:
	@cd docker/nginx && docker build -t shinofara/serf_nginx .

build-app:
	@cd docker/app && docker build -t shinofara/serf_app .
