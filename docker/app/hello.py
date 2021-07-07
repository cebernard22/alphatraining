#! /usr/bin/env python3

"""(Too) basic python module to test the creation of a docker image
   The only purpose is to print "Hello from docker" when the container is started
"""
import time

while True:
   print('Hello from docker')
   time.sleep(1)