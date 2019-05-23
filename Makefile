.PHONY: build, deploy, install

.DEFAULT_GOAL := install

build:
	@echo '=> Building and submitting container to Google Cloud Registry...'
	gcloud builds submit --tag gcr.io/${PROJECT_ID}/indieweb-endpoints-cc-web

deploy:
	@echo '=> Deploying image to Google Cloud Run...'
	gcloud beta run deploy --image gcr.io/${PROJECT_ID}/indieweb-endpoints-cc-web

install:
	@echo '=> Installing Ruby dependencies with Bundler...'
	bundle install
