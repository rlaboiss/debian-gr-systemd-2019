import sys
import re
import pandas as pd
import math

vote = pd.DataFrame (columns = ['voter', 'F', 'B', 'A', 'D', 'H', 'E', 'G', 'fd'],
                     index = None)

for line in sys.stdin.readlines ():
    m = re.match ('^V: ([-1-8]+)\s+(\w+).*', line)
    if m:
        ## Get voter and their choices
        choices = list (m.group (1))
        voter = m.group (2)
        ## Get minimum and maximum values
        minv = 8
        maxv = 1
        for c in choices:
            try:
                ival = int (c)
                if ival < minv:
                    minv = ival
                if ival > maxv:
                    maxv = ival
            except ValueError:
                pass
        ## Compute the rank for the unlisted options
        unlist_rank = min ([8, maxv + 1])
        for i in range (len (choices)):
            if choices [i] == '-':
                choices [i] = unlist_rank
            else:
                choices [i] = int (choices [i])

        if math.isnan (vote.index.max ()):
            idx = 0
        else:
            idx = vote.index.max () + 1
        vote.loc [idx] = [voter] + choices

vote.to_csv ('vote-2019-002.csv', index = False)
