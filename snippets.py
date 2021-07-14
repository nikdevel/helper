l, n = [int(i) for i in input().split()], int(input())
print(*[x for x in range(len(l)) if l[x]==n] if n in l else ["Not found"])
