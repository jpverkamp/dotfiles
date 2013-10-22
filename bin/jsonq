#!/usr/bin/env python

from __future__ import print_function

import gzip
import json
import pprint
import sys
import urllib2

from collections import defaultdict as ddict

# Check usage
def usage():
    print('''Usage: jsonq [options] [file ...]

Options:
  --[c]ount 
      print a count of each unique entry that matches the query, defaults to false
  --[f]ilter [not] query file
      only consider records where any field matching a json query is in the given file
      if not is present, invert the filter
      the default is no filter
  --[h]elp
      display usage
  --[o]ne [query]
      return only one entry from a given query (the first)
  --[q]uery [query]
      the query to run on the json objects, it should be a path within the json objects
      use '-' to return all values, this is the default
  --[s]ort [key|val]?
      defult is to not sort, use whatever default order
      if sorting, key is default; if key, sort by query; if val, sort by count

Input files can be either plaintext, gzipped, or - for stdin.

Examples:
jsonq --query user/id [files]
jsonq --count --query entites/hashtags/text [files]
jsonq --filter not id [id file] --query user/screen_name [files]
''')
    sys.exit(0)

if len(sys.argv) == 1 or '-h' in sys.argv or '--help' in sys.argv:
    usage()

args = sys.argv[1:]

# Check for the count flag
print_count = False
if '--count' in args or '-c' in args:
    print_count = True
    args.remove('--count' if '--count' in args else '-c')

# Check for debug flag
debug_mode = '--debug' in args
if debug_mode:
    args.remove('--debug')

# Check for the filter flag
filtering = False
filter_query = None
filter_file = None
filter_values = []
filter_not = False
if '--filter' in args or '-f' in args:
    try:
        filter_index = args.index('--filter' if '--filter' in args else '-f')

        filter_not = args[filter_index + 1].lower() == 'not'
        if filter_not:
            del args[filter_index + 1]

        filter_query = args[filter_index + 1].split('/')
        filter_file = args[filter_index + 2]
        filter_values = []
        if filter_file == '-':
            fin = sys.stdin
        elif filter_file.endswith('gz'):
            fin = gzip.open(filter_file, 'rb')
        else:
            fin = open(filter_file, 'r')

        for line in fin:
            filter_values.append(line.strip())

        fin.close()

        for i in xrange(3):
            del args[filter_index]

        filtering = True
    except:
        usage()

# Get the query
if '--query' in args or '-q' in args:
    try:
        query_index = args.index('--query' if '--query' in args else '-q')
        query = args[query_index + 1].split('/')
        for i in xrange(2):
            del args[query_index]
    except:
        usage()
else:
    query = []

# Check for the one option
one_enabled = False
one_query = None
one_set = set()
if '--one' in args or '-o' in args:
    #try:
        one_enabled = True
        one_index = args.index('--one' if '--one' in args else '-o')
        one_query = args[one_index + 1].split('/')
        if one_query == ['-']: 
            one_query = []
        for i in xrange(2):
            del args[one_index]
    #except:
    #    usage()

# Check for sorting options
sort_on = None
if '--sort' in args or '-s' in args:
    sort_index = args.index('--sort' if '--sort' in args else '-s')
    sort_on = 'key'
    try:
        if args[sort_index + 1] == 'key':
            sort_on = 'key'
            del args[sort_index + 1]
        elif args[sort_index + 1] == 'val':
            sort_on = 'val'
            del args[sort_index + 1]
    except:
        pass
    del args[sort_index]

# Pull apart the query and file list
files = args

# If not files are specified, use stdin
if not files:
    files = ['-']

# Special query to output everything
if query == ['-']:
    query = []

# DEBUG
debug_width = 80 - 15 - 2 - 1
if debug_mode:
    for key in ['print_count', 'filtering', 'filter_query', 'filter_file', 'filter_values', 'filter_not', 'open_query', 'sort_on', 'query', 'files']:

        val = str(locals()[key] if key in locals() else globals()[key])
        
        if len(val) > debug_width - 3:
            val = val[:debug_width - 3] + '...'

        print('%15s: %s' % (key, val))

# Initialize results
results = ddict(lambda : 0)

# A function to recusrively lookup entries in a json record
# Map over all entries in a list, otherwise use the query
def lookup(js, query):
    if isinstance(js, list):
        for subjs in js:
            for result in lookup(subjs, query):
                yield result
    elif query:
        if query[0] in js:
            for result in lookup(js[query[0]], query[1:]):
                yield result
        else:
            pass
    else:
        yield json.dumps(js)

# Loop over files
for file in files:
    # Load from stdin
    if file == '-':
        fin = sys.stdin
    # Load gzipped files
    elif file.endswith('gz'):
        fin = gzip.open(file, 'rb')
    # Load a plaintext file
    else:
        fin = open(file, 'r')

    # Each line should be a json entry
    # Theoretically, it might work otherwise 
    for line in fin:
        try:

            js = json.loads(line)
            one_break = False

            # If --one is enabled, only tests a json record if we haven't before
            if one_enabled:
                skip = False
                for one_result in lookup(js, one_query):
                    if one_result in one_set:
                        skip = True
                    else:
                        one_break = True
                        one_set.add(one_result)

                if skip:
                    continue

            # If we're filtering, check the filter condition first
            if filtering:
                if filter_not:
                    skip = False
                    for filter_result in lookup(js, filter_query):
                        if filter_result in filter_values:
                            skip = True
                            break

                else:
                    skip = True
                    for filter_result in lookup(js, filter_query):
                        if filter_result in filter_values:
                            skip = False
                            break

                if skip:
                    continue

            # Loop through all possible results
            for result in lookup(js, query):
                results[result] += 1

                # If we were only filtering one, only return the first from each record too
                if one_break: 
                    break

        except Exception, e:
            print('>>> ERROR <<<', sys.stderr)
            print('Reason: %s' % e, sys.stderr)
            print('  json: %s' % line, sys.stderr)
            sys.exit(1)

    # Done
    fin.close()

# Print a count for each unique entry
if sort_on:
    if sort_on == 'val':
        for i, result in sorted([(val, query) for query, val in results.items()]):
            if print_count:
                try:
                    print('%s,%d' % (result, i))
                except:
                    print('%s,%d' % (result.encode('utf-8'), i))
            else:
                print(result)
    else:
        for result, i in sorted(results.items()):
            if print_count:
                try:
                    print('%s,%d' % (result, i))
                except:
                    print('%s,%d' % (result.encode('utf-8'), i))
            else:
                print(result)
else:
    for result, i in results.items():
        if print_count:
            try:
                print('%s,%d' % (result, i))
            except:
                print('%s,%d' % (result.encode('utf-8'), i))
        else:
            print(result)        
