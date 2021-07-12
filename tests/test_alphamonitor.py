#! /usr/bin/env python3

from alphamonitor import jira_exporter 

def test_add_one():
    res=jira_exporter.add_one(4)
    assert  res== 5, 'add_one did not work as expected :-( '
