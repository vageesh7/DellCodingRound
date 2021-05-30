def firstnonrepeatingchar(s):
  order = []
  counts = {}
  for x in s:
    if x in counts:
      counts[x] += 1
    else:
      counts[x] = 1
      order.append(x)
  for x in order:
    if counts[x] == 1:
      return x, s.index(x)
  return -1

print(firstnonrepeatingchar('abcabc'))
