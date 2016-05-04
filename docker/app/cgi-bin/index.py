#!/usr/bin/python
# -*- coding: utf-8 -*-
import CGIHTTPServer
import os

print "Content-type: text/html"
print
print "<html>"
print "Hello " + os.environ["HOSTNAME"]
print "</html>"

