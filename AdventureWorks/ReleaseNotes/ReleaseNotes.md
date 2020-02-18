
# Release notes
## Notes for release  ${releaseDetails.releaseDefinition.name}
**Release Number**  : ${releaseDetails.name}
**Release completed** : ${releaseDetails.modifiedOn}
**Compared Release Number**  : ${compareReleaseDetails.name}


# Document purpose

This document is produced as a release note for the **${releaseDetails.name}** as a result of a release that has been signed off by internal testing.

The release of this document signifies the readiness of the release to be deployed as it is considered a release candidate.

It is imperative that all content in this document is read in full before attempting deployment of any components contained within the release package.

# Summary of release

This release contains a switch in how the code is stored moving from sql files to a database project. There is also a number of issues fixes

## Issues closed

@@WILOOP@@
* ** ${widetail.fields['System.WorkItemType']} ${widetail.id} ** Assigned by: ${widetail.fields['System.AssignedTo']}  ${widetail.fields['System.Title']}
@@WILOOP@@


## Included functionality


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
| ${releaseDetails.name} |  Deploy using DacPac Powershell script|


## Sign off

|Testing Carried out by| Thomas Fynes |
|--|--|
| **Approvals** | **Name**  |
|Test lead approval| Thomas Fynes|
|Dev Lead approval|Thomas Fynes   |
|Release approval| Thomas Fynes  |
