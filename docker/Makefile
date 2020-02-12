all: kafka-cluster

export MY_IP := $(shell ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2)
kafka-cluster:
	docker-compose -f docker-compose-kafka-cluster.yml down && docker-compose -f docker-compose-kafka-cluster.yml up
