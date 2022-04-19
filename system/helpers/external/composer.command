#!/bin/bash
export CURRENT="$(dirname "$0")"
cd $CURRENT

array=( \
	voku/anti-xss \
)

for i in "${array[@]}"
do
	URL="$i"
	ASSET=`basename "$URL"`
	ASSET=${ASSET%%\?*}
	FILENAME=$(echo "$ASSET" | sed -e 's/\.[^.]*$//')
	if [ -d "$FILENAME" ]; then
		rm -rf $FILENAME
	fi
	mkdir $FILENAME
	cd $FILENAME
	composer require $URL
	cd ../
done
