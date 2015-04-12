#!/usr/bin/env python3
from sys import stdin


def parse_line(l):
    """
    Format is specified here:
        http://www.minorplanetcenter.net/iau/info/MPOrbitFormat.html]
    """
    try:
        return (
            # Des'n
            l[0:7],
            # H
            l[8:13],
            # G
            l[14:19],
            # Epoch
            l[20:25],
            # M
            l[26:35],
            # Peri.
            l[37:46],
            # Node
            l[48:57],
            # Incl.
            l[59:68],
            # e
            l[70:79],
            # n
            l[80:91],
            # a
            l[92:103],
            # Reference
            l[105],
            # #Obs
            l[107:116],
            # #Opp
            l[117:122],
            # Arc
            l[123:126],
            # rms
            l[137:141],
            # Perts
            l[142:145],
            # Computer
            l[146:149]
        )
    except IndexError:
        return None

xs = filter(
        lambda x: x is not None,
        map(parse_line, stdin.readlines())
    )
prev = None
for x in xs:
    l = len(x)
    if not l == prev:
        print(x)
        print("Value changed", l)
    prev = l
