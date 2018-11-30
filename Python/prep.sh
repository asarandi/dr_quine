#!/bin/bash
echo -e "\n"
cat Colleen.py | tr '\n' '@' | sed 's/@/%c/g' | tr "'" '@' | sed 's/@/%c/g'
echo -e "\n"
cat Colleen.py | tr '\n' '@' | tr "'" '~' | sed 's/[^@~]//g' | sed 's/@/10,/g' | sed 's/~/39,/g'
echo -e "\n\n"

echo -e "\n"
cat Grace.py | tr '\n' '@' | tr "'" '@' | tr '"' '@' | sed 's/@/%c/g'
echo -e "\n"
cat Grace.py | tr '\n' '@' | tr "'" '~' | sed 's/[^@~"]//g' | sed 's/@/10,/g' | sed 's/~/39,/g' | sed 's/\"/34,/g'
echo -e "\n"
