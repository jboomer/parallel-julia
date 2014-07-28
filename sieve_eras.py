import time


# Python generator (coroutine)
def ESieve(N):
    marked = set()
    for p in xrange(2, N+1, 1):
        if p in marked:
            continue
        for m in xrange(p**2, N+1, p):
            marked.add(m)
        yield p


tic = time.time()
prime_sum = sum(p for p in ESieve(20000000))
tac = time.time() - tic

print("Answer = {0}".format(prime_sum))
print("Elapsed time: {0}".format(tac))
