class Solution:
    def smallestNumber(self, num: str, t: int) -> str:
        # Check if t has prime factors other than 2, 3, 5, 7
        temp_t = t
        for p in (2, 3, 5, 7):
            while temp_t % p == 0:
                temp_t //= p
        if temp_t > 1:
            return "-1"

        # Factorizations of digits 1-9 into counts of [2, 3, 5, 7]
        digit_factors = {
            1: (0, 0, 0, 0),
            2: (1, 0, 0, 0),
            3: (0, 1, 0, 0),
            4: (2, 0, 0, 0),
            5: (0, 0, 1, 0),
            6: (1, 1, 0, 0),
            7: (0, 0, 0, 1),
            8: (3, 0, 0, 0),
            9: (0, 2, 0, 0)
        }

        # Prime factorization of t
        c2 = c3 = c5 = c7 = 0
        temp_t = t
        while temp_t % 2 == 0: c2 += 1; temp_t //= 2
        while temp_t % 3 == 0: c3 += 1; temp_t //= 3
        while temp_t % 5 == 0: c5 += 1; temp_t //= 5
        while temp_t % 7 == 0: c7 += 1; temp_t //= 7

        def can_satisfy(rem2, rem3, rem5, rem7, rem_len):
            """Returns True if required factors fit within rem_len digits."""
            rem2 = max(0, rem2)
            rem3 = max(0, rem3)
            rem5 = max(0, rem5)
            rem7 = max(0, rem7)

            min_digits = rem5 + rem7
            
            n9 = rem3 // 2
            r3 = rem3 % 2
            n8 = rem2 // 3
            r2 = rem2 % 3

            if r2 == 1 and r3 == 1:
                min_digits += 1  # 6
            elif r2 == 2 and r3 == 1:
                min_digits += 2  # 6, 2 or 4, 3
            elif r2 == 2:
                min_digits += 1  # 4
            elif r2 == 1 or r3 == 1:
                min_digits += 1  # 2 or 3

            min_digits += n9 + n8
            return min_digits <= rem_len

        def construct_suffix(rem2, rem3, rem5, rem7, rem_len):
            """Constructs lexicographically smallest suffix of length rem_len."""
            res = []
            for position in range(rem_len):
                remaining_slots = rem_len - 1 - position
                for d in range(1, 10):
                    f2, f3, f5, f7 = digit_factors[d]
                    if can_satisfy(rem2 - f2, rem3 - f3, rem5 - f5, rem7 - f7, remaining_slots):
                        res.append(str(d))
                        rem2 -= f2
                        rem3 -= f3
                        rem5 -= f5
                        rem7 -= f7
                        break
            return "".join(res)

        n = len(num)
        
        pref2, pref3, pref5, pref7 = [0]*(n+1), [0]*(n+1), [0]*(n+1), [0]*(n+1)
        first_zero = -1

        for i, ch in enumerate(num):
            d = int(ch)
            if d == 0:
                if first_zero == -1:
                    first_zero = i
                pref2[i+1], pref3[i+1], pref5[i+1], pref7[i+1] = pref2[i], pref3[i], pref5[i], pref7[i]
            else:
                f2, f3, f5, f7 = digit_factors[d]
                pref2[i+1] = pref2[i] + f2
                pref3[i+1] = pref3[i] + f3
                pref5[i+1] = pref5[i] + f5
                pref7[i+1] = pref7[i] + f7

        # Check if num itself (with no zeroes) works
        if first_zero == -1 and pref2[n] >= c2 and pref3[n] >= c3 and pref5[n] >= c5 and pref7[n] >= c7:
            return num

        # If there is a zero at index first_zero, we can process up to index first_zero
        max_idx = n if first_zero == -1 else first_zero

        # Try matching prefix up to index i-1 and replacing num[i] with digit d > num[i]
        for i in range(max_idx, -1, -1):
            if i == n:
                continue

            curr_2, curr_3, curr_5, curr_7 = pref2[i], pref3[i], pref5[i], pref7[i]

            start_digit = int(num[i]) + 1
            for d in range(start_digit, 10):
                f2, f3, f5, f7 = digit_factors[d]
                rem_2 = c2 - (curr_2 + f2)
                rem_3 = c3 - (curr_3 + f3)
                rem_5 = c5 - (curr_5 + f5)
                rem_7 = c7 - (curr_7 + f7)
                rem_length = n - 1 - i

                if can_satisfy(rem_2, rem_3, rem_5, rem_7, rem_length):
                    suffix = construct_suffix(rem_2, rem_3, rem_5, rem_7, rem_length)
                    return num[:i] + str(d) + suffix

        # If length n cannot satisfy t, find the minimal target length > n
        target_len = n + 1
        while not can_satisfy(c2, c3, c5, c7, target_len):
            target_len += 1

        return construct_suffix(c2, c3, c5, c7, target_len)