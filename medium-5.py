"""
Task 1: the Progress Report

Input:
8
1 5
1 7
1 1
1 2
3 2 4
3 2 4
2
3 4 6

Output:
13
10
8
"""

n = int(input())
result = []
cases = []

for i in range(n):
	E = list(map(int, input().split()))
	if E[0] == 1:
		cases.append(E[1])
	elif E[0] == 2:
		if cases != []:
			del cases[-1]
	else:
		result.append(sum([i for i in cases[i-E[2]:i-E[1]+1]]))

for i in result:
	print(i)