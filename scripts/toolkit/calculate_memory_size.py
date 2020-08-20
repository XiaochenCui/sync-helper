import sys
import math

start = sys.argv[1]
end = sys.argv[2]
expr = "0x{} - 0x{}".format(start, end)
result = abs(eval(expr))
print("size: {:.1f} byte, {:.1f} kb, {:.1f} mb".format(result, result/1024, result/1024/1024))