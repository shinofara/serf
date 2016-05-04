#!/usr/bin/env python
# -*- coding: utf-8 -*-
from serf_master import SerfHandler, SerfHandlerProxy
from jinja2 import Environment, FileSystemLoader
import logging
import sys 
import bsddb
import json
import subprocess
import os


class AppHandler(SerfHandler):
    def member_join(self):
        # maybe rebalance the load balancer
        env = Environment(loader=FileSystemLoader('/usr/local/src/python/', encoding='utf8'))
        tpl = env.get_template('nginx.tpl.conf')
        ips = []
        db=bsddb.hashopen('hashtest.db','c')

        try:
          dbips = json.loads(db["ips"])
          for ip in  dbips:
              ips.append(ip)
        except:
          print "no cache"

        for line in iter(sys.stdin.readline, ""):
            print line
            agent = line.split("\t")
            node = agent[0] #node
            ip = agent[1] #node
            role = agent[2] #node

            if role == "app":
                ips.append(ip)

        db["ips"] = json.dumps(ips)
        db.sync()

        html = tpl.render({'backends':ips})

        f = open("/etc/nginx/conf.d/proxy.conf", "w")
        f.write(html)
        f.close()
        
        cmd = 'supervisorctl restart nginx'
        ret  =  subprocess.check_output( cmd.split(" ") )
        print ret

if __name__ == '__main__':
    handler = SerfHandlerProxy()

    # 存在するappとdefaultのみ許可される
    handler.register('default', AppHandler())
    handler.run()
