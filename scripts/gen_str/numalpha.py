import string

s = '['
for c in string.digits +  string.ascii_uppercase:
    s += '\'' + c + '\', '

s = s[:len(s)-1]
s += ']'

print(s)


s = '['
i = 0
for c in string.digits +  string.ascii_uppercase:
    s += '\'' + c + '0' + '\', '
    s += '\'' + c + 'H' + '\', '
    i += 1

s = s[:len(s)-1]
s += ']'

print(s)
