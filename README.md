# Overview
A short Bash script for finding a dSYM with a specific build uuid from a folder

It can be tedious to find a dSYM for a specific build uuid. This script will search a given folder for a dSYM with a specific build uuid.

# Where to find build uuid for a New Relic crash report
The build uuid for a crash is not currently available in the UI (stay tuned as this will be available later this year).

To find the build uuid of a crash you'll need to edit the URL of the crash detail and add `.json` to the end. Then locate the value for `build_uuid`.

```
https://rpm.newrelic.com/accounts/{ACCOUNT}/mobile/{APP}/crash_reports/{REPORT_ID}.json
```

# How to use
Run the script with the following arguments
`./find_build_uuid.sh  FolderWithDSYMs Build_uuid`

**FolderWithDSYMs** = Path to folder containing dSYM files to be uploaded

**AppKeyNumber** = The 32 character build uuid

# Troubleshooting

A log file is created at `/tmp/find_build_uuid_log.txt`

# Disclaimer
This script is offered for use as-is without warranty. You are free to use and modify as needed. It has been created for use with New Relic crash reporting to simplify the dSYM upload process but is not a supported product of New Relic.

# To Do

* Add ability to upload the dSYM if found
