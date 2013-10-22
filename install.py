#!/usr/bin/env python

import os
import sys

def run(cmd, *args):
    cmd = cmd.format(*args)
    print(cmd)
    os.system(cmd)

for file in sorted(os.listdir('.')):
    if file.startswith('.') or file.endswith('~'): continue
    if file == 'install.py': continue
    
    new_file = os.path.abspath(os.path.expanduser('~/.{0}'.format(file)))
    file = os.path.abspath(file)

    if os.path.isdir(file):
        if not os.path.exists(new_file):
            run('mkdir -p "{0}"', new_file)
        run('cp -r {0}/* {1}', file, new_file)
    else:
        run('cp -r {0} {1}', file, new_file)
