# Makefile

#boot docker and open bash
bash:
	docker compose up -d && docker compose exec terraform /bin/bash -c "source ~/.bashrc && exec /bin/bash" 

#stop docker containers
stop:
	docker compose stop

#down docker
down:
	docker compose down

#delete image
rm_images:
	docker image rm google/cloud-sdk:stable && docker image rm terraform-gcp-with-docker:latest

# /// AUTHENTICATION TO GOOGLE CLOUD ///
#auth individual environment
auth-dev:
	docker compose run --rm gcloud gcloud auth application-default login --project sample-app-dev

auth-staging:
	docker compose run --rm gcloud gcloud auth application-default login --project sample-app-staging

auth-prod:
	docker compose run --rm gcloud gcloud auth application-default login --project sample-app-prod