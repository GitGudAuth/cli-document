#!/bin/bash
#
lscpu | grep '^CPU(s):' | head -1 | sed 's/[ \t]//g' && free -h | awk '/^Mem:/ {print $1 $2}' && df -Th /
lscpu | grep '^CPU(s):' | head -1 | sed 's/[ \t]//g' > spec.txt
free -h | awk '/^Mem:/ {print $1 $2}' >> spec.txt
df -Th / >> spec.txt
