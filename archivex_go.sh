#!/bin/bash

#variables

DEPTH=1
TDIR="/home/punarvasu/temp"
DAYS=10

if [[ ! -d "$TDIR" ]]
then
	echo "The path isn't available"
	exit 1
fi

if [[ ! -d "$TDIR/archive" ]]
then
	mkdir -p "$TDIR/archive" ||exit 1
fi

while IFS= read -r -d '' i
do
	echo "[$(date "+%Y-%m-%d %H:%M:%S" )] archiving==> $i in $TDIR/archive"
 	gzip "$i" || exit 1
	mv "${i}.gz" "$TDIR/archive" || exit 1
done < <( find "$TDIR" -maxdepth $DEPTH -type f -size +20M -mtime +"$DAYS" -print0 )

echo"Archiving Completed"

