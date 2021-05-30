n_choc = 7
m_child = 5

eq = n_choc // m_child
remaining = n_choc - (eq * m_child)

result = {}
for i in range(1, m_child+1):
    result[i] = eq
for i in range(1, remaining+1):
    result[i] = result[i] + 1
print(result)