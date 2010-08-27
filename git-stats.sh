#!/bin/bash
START=18.07.2010
END=25.07.2010
echo "Number of commits per author:"
git --no-pager shortlog --after=$START --before=$END  -sn --all
AUTHORS=$( git shortlog --after=$START --before=$END  -sn --all | cut -f2 | cut -f1 -d' ' ; echo 'Unknowen')
LOGOPTS=""
if [ "$1" == '-w' ]; then
    LOGOPTS="$LOGOPTS -w"
    shift
fi
if [ "$1" == '-M' ]; then
    LOGOPTS="$LOGOPTS -M"
    shift
fi
if [ "$1" == '-C' ]; then
    LOGOPTS="$LOGOPTS -C --find-copies-harder"
    shift
fi
for a in $AUTHORS:
do
    echo '-------------------'
    echo "Statistics for: $a"
    echo -n "Number of files changed: "
    git log $LOGOPTS --after=$START --before=$END --all --numstat --format="%n" --author=$a | cut -f3 | sort -iu | wc -l
    echo -n "Number of lines added: "
    git log $LOGOPTS --after=$START --before=$END --all --numstat --format="%n" --author=$a | cut -f1 | awk '{s+=$1} END {print s}'
    echo -n "Number of lines deleted: "
    git log $LOGOPTS --after=$START --before=$END --all --numstat --format="%n" --author=$a | cut -f2 | awk '{s+=$1} END {print s}'
done
