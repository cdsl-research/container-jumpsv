ALT_NAME=sshsv
VER=v0.1
CONTAINER_NAME=container-jumpsv

build:
	sudo docker build -t $(CONTAINER_NAME) .

run:
	sudo docker run -it --rm -p 22:22 --name $(ALT_NAME) $(CONTAINER_NAME)

exec:
	sudo docker exec -it $(ALT_NAME) sh

push:
	sudo docker tag $(CONTAINER_NAME) ghcr.io/tomoyk/stns-container/$(CONTAINER_NAME):$(VER)
	sudo docker push ghcr.io/tomoyk/stns-container/$(CONTAINER_NAME):$(VER)
