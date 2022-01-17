TAG ?= latest
REGISTRY_ID ?= 163715734974
REPOSITORY_REGION ?= eu-central-1
APP_NAME ?= flaskapp
ENV_NAME ?= dev
REPO_NAME = $(REGISTRY_ID).dkr.ecr.$(REPOSITORY_REGION).amazonaws.com/final-demo

.PHONY: build
build:
	$(MAKE) docker-login
	docker build -t $(REPO_NAME):$(TAG) -f ./Dockerfile .
	docker push $(REPO_NAME):$(TAG)

.PHONY: docker-login
docker-login:
	aws ecr get-login-password \
		--region $(REPOSITORY_REGION) \
	| docker login --username AWS --password-stdin \
		$(REGISTRY_ID).dkr.ecr.$(REPOSITORY_REGION).amazonaws.com

