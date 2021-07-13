#! /usr/bin/env python3

"""basic python file to test the creation of a python module
   The only purpose is to increase a number by one from TravisCI
   At a latter stage this module will interact with Jira and retrieve how many open issues we have
"""

def add_one(number):
    print("Message for test purpose only to ckeck for distribution update")
    return number + 1

def missing_coverage(number):
    print("This function has no test defined. Built to tweak coverage result")