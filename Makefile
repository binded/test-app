CI_IMAGE := "binded/ci:1.0.0"

DOCKER_RUN_BASE = docker run \
	--rm \
	--privileged \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v $(PWD):/ci/repo \
	--env ENVIRONMENT \
	--env SLACK_DEV_WEBHOOK_URL \
	--env AWS_ACCESS_KEY_ID \
	--env AWS_SECRET_ACCESS_KEY

DOCKER_RUN := $(DOCKER_RUN_BASE) $(CI_IMAGE)

all:
	$(DOCKER_RUN) make build
	$(DOCKER_RUN) make run-test
	$(DOCKER_RUN) make push
	$(DOCKER_RUN) make deploy

.PHONY: run-interactive
run-interactive:
	$(DOCKER_RUN_BASE) -it $(CI_IMAGE) make run-interactive
