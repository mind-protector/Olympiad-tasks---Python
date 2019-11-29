# Task 1: to Drink a cup of coffee
# Input: 10 2 3
# Output: 8

n, a, b = map(int, input().split())
# 0 2 4 6 8 10
# 0 3 6 9
# 0 2 3 4 6 8 9 10
print(len(set([i for i in range(n+1) if (i % a == 0) or (i % b == 0)])))
