l, n = [int(i) for i in input().split()], int(input())
print(*[x for x in range(len(l)) if l[x]==n] if n in l else ["Not found"])

######### 
line, matrix, lI = input(), [], 0
# lI - count of rows in matrix
# lJ - count of columns in matrix
#  sum of neighboring elements
[([print(matrix[i - 1][j] + matrix[i][j - 1] + matrix[i][(j + 1) % lJ] + matrix[(i + 1) % lI][j], end=' ') for j in range(lJ)], print()) for i in range(lI)]
