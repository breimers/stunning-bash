#!/bin/bash
## concantenates all files as text in dir to new file
for i in $(ls); do cat $i | tail +3 | sed 's/>//g' | sed 's/-//g' | sed 's/*//g' | sed 's/|//g' | sed 's/#//g' | sed 's/>//g' | sed 's/)//g' | sed 's/)//g' | sed 's/~//g' | sed 's/-//g' | sed 's/_//g' | sed 's/^.* \([^@ ]\+@[^ ]\+\) \?.*$//g' | tr "\n\r\t" ' ' | tr -d "/\()" | sed 's/=//g' | sed -r 's/[^[:space:]]*[0-9][^[:space:]]* ?//g' | sed 's/\$//g' | sed 's/  */ /g' | sed 's/\+//g' | sed 's|\\||g' | sed 's/\%//g' | sed 's/V*//g' | sed 's/@//g' | sed '' >> compendium.txt; done
