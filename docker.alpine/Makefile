ALT_NAME=sshsv
VER=v0.1.1
CONTAINER_NAME=container-jumpsv

build:
	docker build -t $(CONTAINER_NAME) .

run:
	docker run -it --rm -d -p 22:22 --name $(ALT_NAME) $(CONTAINER_NAME)

exec:
	docker exec -it $(ALT_NAME) sh

push:
	docker tag $(CONTAINER_NAME) ghcr.io/tomoyk/stns-container/$(CONTAINER_NAME):$(VER)
	docker push ghcr.io/tomoyk/stns-container/$(CONTAINER_NAME):$(VER)
