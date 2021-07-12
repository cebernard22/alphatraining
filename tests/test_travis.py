#! /usr/bin/env python3

"""First python module to test triggering in Travis CI.
Random value as an outcome to simulate fail/pass criteria
"""


import random



def test_simpleTest():
    dummyValue=random.randint(0, 9)
    if dummyValue>=5 :
        res=1;
    else:
        res=-1;
    print( "Test outcome:",res)
    assert res > 0, 'Test failed'




