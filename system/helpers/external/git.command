#!/bin/bash
export CURRENT="$(dirname "$0")"
cd $CURRENT

array=( \
	https://github.com/JamesHeinrich/phpThumb.git \
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
	git clone $URL
done

# BEGIN after clone
# Manually phpthumb 1.7.16 edit readfile in phpThumb.php change to echo file_get_contents
mv phpThumb/phpThumb.config.php.default phpThumb/phpThumb.config.php
grep -q -F "get_config('PHPTHUMB_CONFIG');" phpThumb/phpThumb.config.php || \
cat phpThumb/phpThumb.config.php | \
sed -E "s/\/\* END DEFAULT PARAMETERS SECTION \*\//\/* END DEFAULT PARAMETERS SECTION *\/\\$(echo -e '\n\r')\$PHPTHUMB_CONFIG = get_config('PHPTHUMB_CONFIG');/g" \
	> \
	phpThumb/phpThumb.config.php
