# -*- coding: utf-8 -*-

import os
import sys
import json


redis_index = sys.argv[1]
project_name = sys.argv[2]

if os.path.isfile(redis_index):
    f = open(redis_index, 'r')
    index = json.load(f)
    f.close()
else:
    index = {}
if project_name not in index:
    if index:
        index[project_name] = max(index.values()) + 1
    else:
        index[project_name] = 1
    f = open(redis_index, 'w')
    json.dump(index, f)
    f.close()
print index[project_name]
