
# Release notes
## Notes for release  ${releaseDetails.releaseDefinition.name}

**Release Number**  : ${releaseDetails.name}

**Release completed** : ${releaseDetails.modifiedOn}

**Compared Release Number**  : ${compareReleaseDetails.name}


# Document purpose

This document is produced as a release note for the **${releaseDetails.releaseDefinition.name}** as a result of a release that has been signed off by internal testing.

The release of this document signifies the readiness of the release to be deployed as it is considered a release candidate.

It is imperative that all content in this document is read in full before attempting deployment of any components contained within the release package.

# Summary of release

This release contains a switch in how the code is stored moving from sql files to a database project. There is also a number of issues fixes

## Issues closed

@@WILOOP@@
* ** ${widetail.fields['System.WorkItemType']} ${widetail.id} ** Assigned by: ${widetail.fields['System.AssignedTo']}  ${widetail.fields['System.Title']}
@@WILOOP@@


## Included functionality

*	Administration.
    *	Add database to Availability Group.
    *	Backup a whole database.
    *	Backup a database log.
    *	Audit of all SQL Server database files on a drive of the server (regardless of if mounted).
    *	Database Snapshot Creation (used by EMISIQ Extraction Automation Tool).
    *	Database deletion.
    *	Database Snapshot Deletion (used by EMISIQ Extraction Automation Tool).
    *	Functionality to identify unmounted database files.
    *	Remove database from Availability Group.
    *	Restore database.
*	Audit.
    *	Tracing for all EMISGROUP or PURPLE account actions, or system initiated actions that exceed defined thresholds.
    *	Functionality to elevate SQL Write group permissions in the Quiet Period window for patching interventions that may be required.
*	Configuration.
    *	Add or remove Trace Flags based on best practice for the instance unless specifically overridden.
    *	Support to block Person Identifiable Data access for all but named groups/accounts based on metadata. This functionality is disabled by default.
    *	Apply instance level security settings in line with best practice.
    *	Check and correct (if applicable) database security in line with best practice. 
    *	Check and correct (if applicable) database settings in line with best practice. 
    *	Check and correct (if applicable) SQL Server Agent Job security in line with best practice.
    *	Correct EMISGroupDBA SQL Server Agent Job start times based on the defined Quiet Period.
    *	Create and remove Linked Servers, based on the configuration set.
    *	Enable/disable email alerts for pertinent error messages.
    *	Stop overrunning EMISGroupDBA SQL Server Agent Jobs.
    *	cycling of agent logs
*	Maintenance.
    *	Automated CheckDB.
    *	Automated Error Log cycling.
    *	Deletion of Backup and Restore history after Archive Age (configurable) days.
    *	Automated Index rebuild (configurable threshold).
    *	Automated removal of stale Readable Secondary server statistics.
    *	Automated reorganisation of Fulltext Catalogues.
    *	Automated reorganisation of Indexes (configurable threshold).
    *	Automated resuming of stuck Fulltext Crawl Updates.
    *	Shrinking of database data files.
    *	Automated shrinking of Transaction Log files (configurable threshold).
    *	Automated killing of maintenance when Transaction Log drives come under space pressure.
    *	Automated update of statistics.
*	Monitoring.
    *	Collection of Wait Statistics.
    *	Automatic emailing of pertinent error messages (if enabled).
    *	Collection of AlwaysOn Replica Role, Replication Mode and Failover Mode for all Availability Groups on the instance.
    *	Collection of Cached Execution Plan statistics.
    *	Collection of Transaction Log space usage.
    *	Collection of Memory usage counters.
    *	Collection of Operating System Resource usage counters.
    *	Collection of TempDB space usage couters.
*	Performance.
    *	A Release Assessment tool to compare current performance to a baseline date and time. This functionality is disabled by default.
*	Reporting.
    *	Collection of Mount Point space usage.
    *	Collection of database space usage.
    *	Logging of missed SQL Server database Backups.
    *	Collection of SQL Server Instance property information (memory allocated, CPUs allocated, current SQL Server Build e.t.c.)
    *	Collection of table space usage information.


## Release overview


## Release details

The release can be collected from Group Team Foundation Server in the Hosted Collection under the following path:

[https://github.com/emisgroup/dba-groupmanagement-database/releases](https://github.com/emisgroup/dba-groupmanagement-database/releases)

# Release dependencies

None


## Release deployment

This section details the deployment instructions. This information is provided by Development. If there are any problems, refer to the Development contact listed in the release overview.


|Product| Deployment Details  |
|--|--|
| ${releaseDetails.releaseDefinition.name} |  Deploy using DacPac Powershell script|


## Sign off

|Testing Carried out by| Thomas Fynes |
|--|--|
| **Approvals** | **Name**  |
|Test lead approval| Thomas Fynes|
|Dev Lead approval|Thomas Fynes   |
|Release approval| Thomas Fynes  |
