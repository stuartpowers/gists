
# Stuart Powers
# report when any google docs are created or changed


import os
import sys
import simplejson
import gdata.docs.service


"""
This script will report which google docs have been modified or created since
it was last run.

It compares the timestamps retrieved from google with the timestamps from the
JSON file which is updated each time the script is called.  It compares each
document's last-updated timestamp against what they were the previous time the
script was ran, it does this by using a 'docs.json' to save state.

Inspired by the stackoverflow question:
    "How to hit a URL when Google docs spreadsheet is changed"
    http://stackoverflow.com/questions/8927164/

"""


docs = gdata.docs.service.DocsService()
docs.ClientLogin('stuart.powers@gmail.com','xxxxxxxx')



# create a dictionary of doc_id/timestamp key/values
mydict = {}
for e in docs.GetDocumentListFeed().entry:
    mydict[e.id.text] = e.updated.text


# if docs.json doesn't exist, create it with our dict's data and then exit
# because there's nothing to compare against
if not os.path.exists('docs.json'):
    with open('docs.json','w') as o:
        o.write(simplejson.JSONEncoder().encode(mydict))
    sys.exit(0)


# otherwise, load the previous data from docs.json
last_data = simplejson.load(open('docs.json'))

# and compare the timestamps
for id in mydict.keys():
    if id not in last_data:
        print 'new: %s' % id
    if mydict[id] != last_data[id]:
        print 'changed: %s' % id


# update docs.json for next time and then quit
with open('docs.json','w') as o:
    o.write(simplejson.JSONEncoder().encode(mydict))
