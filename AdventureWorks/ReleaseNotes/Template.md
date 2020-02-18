# Release notes
## Notes for release  ${releaseDetails.releaseDefinition.name}
**Release Number**  : ${releaseDetails.name}
**Release completed** : ${releaseDetails.modifiedOn}
**Compared Release Number**  : ${compareReleaseDetails.name}

### All associated work items
@@WILOOP@@
* ** ${widetail.fields['System.WorkItemType']} ${widetail.id} ** Assigned by: ${widetail.fields['System.AssignedTo']}  ${widetail.fields['System.Title']}
@@WILOOP@@

### Associated work items that have both the tags 'Tag 1' and 'Tag2', the legacy default format
@@WILOOP:Tag 1:Tag2@@
* ** ${widetail.fields['System.WorkItemType']} ${widetail.id} ** Assigned by: ${widetail.fields['System.AssignedTo']}  ${widetail.fields['System.Title']}
@@WILOOP:Tag 1:Tag2@@

### Associated work items that have both the tags 'Tag 1' and 'Tag2', the new loop format
@@WILOOP[ALL]:Tag 1:Tag2@@
* ** ${widetail.fields['System.WorkItemType']} ${widetail.id} ** Assigned by: ${widetail.fields['System.AssignedTo']}  ${widetail.fields['System.Title']}
@@WILOOP[ALL]:Tag 1:Tag2@@

### Associated work items that have any of the tags 'Tag 1' or 'Tag2', the new loop format
@@WILOOP[ANY]:Tag 1:Tag2@@
* ** ${widetail.fields['System.WorkItemType']} ${widetail.id} ** Assigned by: ${widetail.fields['System.AssignedTo']}  ${widetail.fields['System.Title']}
@@WILOOP[ANY]:Tag 1:Tag2@@

### Associated work items that have the title 'This is a title' or the tag 'Tage'
@@WILOOP[ALL]:System.Title=This is a title:TAG 1@@  
* **${widetail.fields['System.WorkItemType']} ${widetail.id}** ${widetail.fields['System.Title']}  
@@WILOOP:TAG 1@@  

### Associated commits
@@CSLOOP@@
* **ID ${csdetail.id} ** ${csdetail.message}
@@CSLOOP@@