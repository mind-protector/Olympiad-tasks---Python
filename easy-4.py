# Task 4: a Series of numbers
# Input: 3
# Output: ++-

n = int(input())

if (n % 4 == 1) or (n % 4 == 2):
	print("IMPOSSIBLE")

elif n % 4 == 3:
	print("++-" + "+--+" * (n // 4))

else:
	print("+--+" * (n // 4))
