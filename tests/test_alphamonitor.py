#! /usr/bin/env python3

from alphamonitor import jira_exporter 

def test_add_one():
    res=jira_exporter.add_one(4)
    assert  res== 5, 'add_one did not work as expected :-( '


def test_add_two():
    res=jira_exporter.add_two(4)
    if res==6:
        print('Test passed')
    else:
        print('Test failed')
    assert  res== 6, 'add_two did not work as expected :-( '
