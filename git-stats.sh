#!/bin/bash
echo "Number of commits per author:"
git --no-pager shortlog --after=18.07.2010 --before=24.07.2010  -sn --all
AUTHORS=$( git shortlog --after=18.07.2010 --before=24.07.2010  -sn --all | cut -f2 | cut -f1 -d' ' ; echo 'Unknowen')
for a in $AUTHORS:
do
    echo '-------------------'
    echo "Statistics for: $a"
    echo -n "Number of files changed: "
    git log --after=18.07.2010 --before=25.07.2010 --all --numstat --format="%n" --author=$a | cut -f3 | sort -u | wc -l
    echo -n "Number of lines added: "
    git log --after=18.07.2010 --before=25.07.2010 --all --numstat --format="%n" --author=$a | cut -f1 | awk '{s+=$1} END {print s}'
    echo -n "Number of lines deleted: "
    git log --after=18.07.2010 --before=25.07.2010 --all --numstat --format="%n" --author=$a | cut -f2 | awk '{s+=$1} END {print s}'
done
