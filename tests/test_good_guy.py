#! /usr/bin/env python3

"""First python module to test triggering in Travis CI.
This test is always a success. Only purpose is to get a least on success in the testlist result :-D
"""





def test_NiceTest():
    dummyValue=9
    if dummyValue>=5 :
        res=1;
    else:
        res=-1;
    print( "Test outcome:",res)
    assert res > 0, 'NiceTest failed...really?'
    return res;




