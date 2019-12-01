"""
Task 1: Two measurement

Input:
1
5
2

Output: 4
"""

l = int(input())
r = int(input())
a = int(input())

A = [i for i in range(1,r+1) if i % a == 0]

S = 0
for i in A:
	if i+l > r:
		break
	else:
		S += len(range(i+1,r+1))

print(S)
