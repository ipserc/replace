#!/bin/bash

_VERION_="1.0"
_CREATION_="2021-03-23"
_MODIFIED_="2021-03-23"
_AUTHOR_="Jose Luis Nuñez Crespi"
_GITHUB_="https://github.com/ipserc/"

usage() {
	echo "Usage: $0 -d directory_to_use -e file_extension -s search_word -r replacement_word -h usage"
	echo "	Version:$_VERION_"
	echo "	Author:$_AUTHOR_"
	echo "	GitHub:$_GITHUB_"
	echo "	Creation date:$_CREATION_"
	echo "	Modified:$_MODIFIED_"
}

checkParams() {
	if [ "$DIR" == "" ] || [ "$EXTENSION" == "" ] || ["$SEARCH" == ""]; then
		usage
		exit 1
	fi
}


doReplaceIn() {
	local pathFile=$1
	# Note the double quotes
	sed -i "s/${SEARCH}/${REPLACE}/g" $pathFile
}

doWalkReplace() {
	for file in `find ${DIR} -name \*.${EXTENSION}`; do
		doReplaceIn $file
	done
}

doConfirm() {
	echo "Replacing '${SEARCH}' with '${REPLACE}' for all '${EXTENSION}' files in '${DIR}'"
	read -p "Enter Y to go ahead:"
	[[ "${REPLY}" == "Y" || "${REPLY}" == "y" ]] || exit 2 
}

####################
# ----- MAIN ----- # 
####################
while getopts d:e:s:r:h option; do
	case "${option}" 
	in
		d) DIR=${OPTARG};;
		e) EXTENSION=${OPTARG};;
		s) SEARCH=${OPTARG};;
		r) REPLACE=${OPTARG};;
		h) usage; exit 0;;
		*) echo "ERROR: Invalid option";usage; exit 3;;

	esac
done

checkParams
doConfirm
doWalkReplace
