# For USF SAIL
# ~Dre, Mihir

import json
import io
import glob
import os

#Optional, use only if you need to fix the jsonl files for csv conversion + fix used clean_json_step1.py
#re-rewrites all the files into jsonl format
results = []
# give path name to a directory, it will write back a BOM file
for f in glob.glob("folder_with_all_jsonl/*.jsonl"):
    with open(f, 'r', encoding='utf-8-sig') as infile:
        for jline in infile:
            try:
                results.append(json.loads(jline)) # read each line of the file
            except ValueError:
                print(f)
    del infile #delete to release some memory back
    with open(f,'w', encoding= 'utf-8-sig') as outfile:
        for result in results:
            try:
                outfile.write(json.dumps(result) + "\n")
            except ValueError:
                print(f)
    del results[:] #clear list
    outfile.close()
