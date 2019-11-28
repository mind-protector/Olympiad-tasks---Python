# Task 5: the Treasure
# Input: 7N5E2S3E10S
# Output: 5N8E

S = list(input())
n = 0

D = {'N':0, 'S':0, 'W':0, 'E':0}

i = 0
while S != []:
	if S[i].isalpha():
		D[S[i]] += int(''.join(S[0:i]))
		del S[0:i+1]
		i -= 1
		continue
	i += 1

print(f"{abs(D['N']-D['S'])}{max(['N', 'S'], key=D.get)}{abs(D['W']-D['E'])}{max(['W', 'E'], key=D.get)}")