import sys

from confluent_kafka import Consumer

from conf import config


if __name__ == '__main__':
    consumber_group = sys.argv[1]
    print 'Consumer group: {}'.format(consumber_group)
    consumer_config = config.kafka_configuration
    consumer_config['group.id'] = consumber_group
    topic = ['test_topic']
    consumer = Consumer(consumer_config)
    consumer.subscribe(topic)
    while True:
        msg = consumer.poll(1)
        if msg:
            print msg.value().encode('hex')
