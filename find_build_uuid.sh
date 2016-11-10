#!/bin/bash
set -e
### HOW TO USE ###
#
# Run script with following variables to search dSYMs
# 		./find_build_uuid.sh  FolderWithDSYMs Build_uuid
#
# Run script with following variables to upload dSYM if found
# 		./find_build_uuid.sh  FolderWithDSYMs Build_uuid "App Name" AppKeyNumber

### Mostly static variables ###
LOGFILE="/tmp/find_build_uuid_log.txt"
ZIP="/usr/bin/zip --recurse-paths --quiet"
URL="https://mobile-symbol-upload.newrelic.com/symbol"

### Variables from command line ###
DSYMDIR=${1}
BUILDID=${2//-}
DSYM="empty"
TEMPID="empty"
APPNAME=$3
APPKEY=$4


### Functions for this script ###

### Print message when there are not enough values passed or they are wrong in some way
function invalidEntry(){
	echo "You must enter the following values:
	Build uuid
	Folder of dSYMs"

	exit 0
}

function logFile(){
	echo "\$ $@" >> ${LOGFILE}; "$@" ;
}

### Validate these values a bit
if [[ ${DSYMDIR} == "" || ${BUILDID} == "" || ${#BUILDID} < 32 ]]; then
	invalidEntry
fi

### Open log file with date and time
date > ${LOGFILE}

### Loop through given directory to search each dSYM
find ${DSYMDIR} -type d -name '*.dSYM' -print0 | while IFS= read -r -d '' DSYM; do
	logFile echo "Searching file" ${DSYM}
	TEMPID=`xcrun dwarfdump --uuid "${DSYM}" | tr '[:upper:]' '[:lower:]' | tr -d '-'| awk '{print $2}' | xargs | sed 's/ /,/g'`

	if [[ ${TEMPID} == *"${BUILDID}"* ]]; then
		logFile echo "The dSYM file ${DSYM} is for build uuid ${BUILDID}"

		if [[ ${APPNAME} != "" && ${#APPKEY} = 42 ]]; then
			logFile echo "Uploading dSYM to New Relic"
			logFile ${ZIP} /tmp/${BUILDID}.zip "${DSYM}"
			logFile curl -F dsym=@"/tmp/${BUILDID}.zip" -F buildId="${TEMPID}" -F appName="${APPNAME}" -H "X-APP-LICENSE-KEY: ${APPKEY}" ${URL}
			logFile rm /tmp/${BUILDID}.zip
		fi

		exit 1
	fi

done

logFile echo "No dSYM file exists with ${BUILDID} in PATH ${DSYMDIR}"

exit 0