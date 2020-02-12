from datetime import datetime

from confluent_kafka import Producer

from conf import config


if __name__ == '__main__':
    producer = Producer(config.kafka_configuration)
    for _ in range(5):
        producer.produce('test_topic', str(datetime.now()))
    producer.flush(1)
