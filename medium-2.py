"""
Task 1: the Sabotage

Input:
2 5 5 1
10 10 
3 2

Output:
42 
5 0
3 2
"""

n, S, p, q = map(int, input().split())
result = []

for i in range(n):
	a, b = 0, 0
	A, B = map(int, input().split())
	if A >= S:
		a = S
	else:
		if B >= S-A:
			a, b = A, S-A
		else:
			a, b = A, B
	result.append([a,b, (a*p + b*q)])

print(sum([i[2] for i in result]))
for i in result:
	print(i[0],i[1])

