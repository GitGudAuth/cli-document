#!/bin/bash
#
lscpu | grep '^CPU(s):' | head -1 | sed 's/[ \t]//g' && free -h | awk '/^Mem:/ {print $1 $2}' && df -hh | awk '$1 != "tmpfs" && $1 != "efivarfs"'
lscpu | grep '^CPU(s):' | head -1 | sed 's/[ \t]//g' > spec.txt

free -h | awk '/^Mem:/ {print $1 $2}' >> spec.txt

df -hh | awk '$1 != "tmpfs" && $1 != "efivarfs"' >> spec.txt
