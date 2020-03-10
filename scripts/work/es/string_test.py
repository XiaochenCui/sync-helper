import binascii

origin_hex_bytes = b'232302011c1c0303ffff'
print(origin_hex_bytes)
print(len(origin_hex_bytes))

b = binascii.unhexlify(origin_hex_bytes)
print(b)
print(len(b))

# s = b.decode()
# s = b.decode('utf-8', 'strict')
# s = b.decode('utf8', 'replace')
# s = b.decode('ascii', 'ignore')
# s = b.decode('ascii', 'replace')
# print('s:')
# print(s)
# # print(s.printable)
# print(repr(s))
# print(len(s))

print('repr s:')
repr_s = repr(b)
print(repr_s)
print(len(repr_s))

print('eval s:')
eval_s = eval(repr_s)
print(eval_s)
print(len(eval_s))
