# Overview
A short Bash script for finding a dSYM with a specific build uuid from a folder

It can be tedious to find a dSYM for a specific build uuid. This script will search a given folder for a dSYM with a specific build uuid.

# Where to find build uuid for a New Relic crash report
To find the build uuid for a crash in Crash Analysis refer to the [Find Build UUIDs for unsymbolicated crashes](https://docs.newrelic.com/docs/mobile-monitoring/mobile-monitoring-ui/crashes/find-build-uuids-unsymbolicated-crashes) doc.

In the old Crash report UI, to find the build uuid of a crash you'll need to edit the URL of the crash detail and add `.json` to the end. Then locate the value for `build_uuid`.

```
https://rpm.newrelic.com/accounts/{ACCOUNT}/mobile/{APP}/crash_reports/{REPORT_ID}.json
```

# How to use
Run the script with the following arguments to search dSYMs

`./find_build_uuid.sh  FolderWithDSYMs Build_uuid`

Run the script with the following arguments to upload dSYM if found

`./find_build_uuid.sh  FolderWithDSYMs Build_uuid "App Name" AppKeyNumber`

**FolderWithDSYMs** = Path to folder containing dSYM files to be uploaded

**Build_uuid** = The 32 character build uuid

**"App Name"** = Name of your application in New Relic.
  *note: App names with spaces must be wrapped in quotes*
  
**AppKeyNumber** = The 42 character [Application token](https://docs.newrelic.com/docs/mobile-monitoring/new-relic-mobile/maintenance/viewing-your-application-token) for your app

# Troubleshooting

A log file is created at `/tmp/find_build_uuid_log.txt`

# Disclaimer
This script is offered for use as-is without warranty. You are free to use and modify as needed. It has been created for use with New Relic crash reporting to simplify the dSYM upload process but is not a supported product of New Relic.
