"""
Task 1: the Buckwheat Harvest Festival

Input:
4
456
008910
1023
90909

Output:
21 
90909 008910 456 1023
"""

n = int(input())
D = {}

for i in range(n):
	k = input()
	D[k] = sum([int(i) for i in k])

N = sorted(D, key=D.get, reverse=True)

print(D[N[0]]-D[N[-1]])
print(' '.join(N))