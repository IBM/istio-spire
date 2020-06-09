#!/usr/bin/python

import sys

def print_patch_lines(filename, k):
  f = open(filename, 'r')
  for line in f.readlines():
    print " " * k + line.rstrip()
  f.close()

def main(argv):
  if len(argv) != 4:
    print "Usage: " + argv[0] + " yaml_file_name volumes_patch_file volume_mount_patch_file"
    sys.exit(1)

  f = open(argv[1], 'r')
  lines = f.readlines()

  i = 0
  while i < len(lines):
      line = lines[i]
      k1 = line.find("volumes:")
      k2 = line.find("volumeMounts:")
      if k1 != -1:
        print line.rstrip()
        i = i + 1
        line = lines[i]
        buf = []
        while line.lstrip()[0] != '-':
          buf.append(line.rstrip())
          i = i + 1
          line = lines[i]
        k1 = len(line) - len(line.lstrip(' '))
        buf.append(line.rstrip())
        print_patch_lines(argv[2], k1)
        for b in buf:
          print b
      elif k2 != -1:
        print line.rstrip()
        i = i + 1
        line = lines[i]
        buf = []
        while line.lstrip()[0] != '-':
          buf.append(line.rstrip())
          i = i + 1
          line = lines[i]
        k2 = len(line) - len(line.lstrip(' '))
        buf.append(line.rstrip())
        print_patch_lines(argv[3], k2)
        for b in buf:
          print b
      else:
        print line.rstrip()
      i = i + 1

  f.close()

if __name__ == "__main__":
   main(sys.argv)
