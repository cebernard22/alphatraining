#! /usr/bin/env python3

"""First python module to test triggering in Travis CI.
Random value as an outcome to simulate fail/pass criteria
"""


import random



def simpleTest():
    dummyValue=random.randint(0, 9)
    print(dummyValue)
    if dummyValue>=5 :
        res=0;
    else:
        res=-1;
    print( "Test outcome:",res)
    return res;


print('Hello from Travis')
simpleTest()

