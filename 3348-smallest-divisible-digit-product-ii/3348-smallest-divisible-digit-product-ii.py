class Solution:
    def smallestNumber(self, num: str, t: int) -> str:
        e2 = e3 = e5 = e7 = 0
        while t % 2 == 0: e2 += 1; t //= 2
        while t % 3 == 0: e3 += 1; t //= 3
        while t % 5 == 0: e5 += 1; t //= 5
        while t % 7 == 0: e7 += 1; t //= 7
        if t != 1:
            return "-1"

        digit_factors = [
            (0,0,0,0),(0,0,0,0),(1,0,0,0),(0,1,0,0),(2,0,0,0),
            (0,0,1,0),(1,1,0,0),(0,0,0,1),(3,0,0,0),(0,2,0,0),
        ]

        B3, B5, B7 = e3+1, e5+1, e7+1
        def idx(a,b,c,d):
            return ((a*B3+b)*B5+c)*B7+d

        size = (e2+1)*B3*B5*B7
        minLen = [0]*size

        for a in range(e2+1):
            for b in range(e3+1):
                for c in range(e5+1):
                    for d in range(e7+1):
                        if a==0 and b==0 and c==0 and d==0:
                            continue
                        best = None
                        for v in range(2,10):
                            da,db,dc,dd = digit_factors[v]
                            na = a-da if a>da else 0
                            nb = b-db if b>db else 0
                            nc = c-dc if c>dc else 0
                            nd = d-dd if d>dd else 0
                            if (na,nb,nc,nd) != (a,b,c,d):
                                cand = 1 + minLen[idx(na,nb,nc,nd)]
                                if best is None or cand < best:
                                    best = cand
                        minLen[idx(a,b,c,d)] = best

        def get_minlen(a,b,c,d):
            return minLen[idx(a,b,c,d)]

        def reduce_state(a,b,c,d,v):
            da,db,dc,dd = digit_factors[v]
            na = a-da if a>da else 0
            nb = b-db if b>db else 0
            nc = c-dc if c>dc else 0
            nd = d-dd if d>dd else 0
            return na,nb,nc,nd

        full_state = (e2,e3,e5,e7)
        minlen_full = get_minlen(*full_state)

        L = len(num)
        digits_num = [int(ch) for ch in num]

        def fill_suffix(state, length):
            a,b,c,d = state
            res = []
            remaining = length
            for _ in range(length):
                remaining -= 1
                for v in range(1,10):
                    na,nb,nc,nd = reduce_state(a,b,c,d,v)
                    if get_minlen(na,nb,nc,nd) <= remaining:
                        res.append(v)
                        a,b,c,d = na,nb,nc,nd
                        break
            return res

        if 0 not in digits_num:
            a,b,c,d = full_state
            for v in digits_num:
                a,b,c,d = reduce_state(a,b,c,d,v)
            if a==0 and b==0 and c==0 and d==0:
                return num

        firstZero = L
        for i,v in enumerate(digits_num):
            if v == 0:
                firstZero = i
                break

        max_pivot = min(firstZero, L-1)

        prefix_states = [None]*(max_pivot+1)
        prefix_states[0] = full_state
        for i in range(1, max_pivot+1):
            prefix_states[i] = reduce_state(*prefix_states[i-1], digits_num[i-1])

        answer = None
        for i in range(max_pivot, -1, -1):
            state = prefix_states[i]
            start_d = digits_num[i] + 1
            remaining_length = L - i - 1
            for dd in range(start_d, 10):
                na,nb,nc,nd = reduce_state(*state, dd)
                if get_minlen(na,nb,nc,nd) <= remaining_length:
                    suffix = fill_suffix((na,nb,nc,nd), remaining_length)
                    answer = digits_num[:i] + [dd] + suffix
                    break
            if answer is not None:
                break

        if answer is not None:
            return ''.join(map(str, answer))

        target_length = max(L+1, minlen_full)
        suffix = fill_suffix(full_state, target_length)
        return ''.join(map(str, suffix))