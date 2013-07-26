#! /usr/bin/env python

from subprocess import check_output
import sys, hashlib

colors = check_output(["tput","colors"]).strip()
hostname = check_output(["hostname", "-s"]).strip()

m = hashlib.md5()
m.update(hostname)
myhash = m.hexdigest()

# print "\033[48;5;255m255:"
color = int(myhash, 16) % int(colors)

sys.stdout.write('\033[38;5;%sm%s\033[0m' % (color, hostname))