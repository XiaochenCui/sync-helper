import random


def split_data_generator(data):
    random.seed()
    l = random.randint(1, 50)
    while len(data) > l:
        yield data[:l]
        data = data[l:]
    if data:
        yield data
