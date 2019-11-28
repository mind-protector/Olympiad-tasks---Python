# Task 3: the Parade
# Input: 180
# Output: 36

n = int(input())
A = 1

i = 2
while i ** 2 <= n:
	if n % (i ** 2) == 0:
		A = i ** 2
	i += 1

print(A)