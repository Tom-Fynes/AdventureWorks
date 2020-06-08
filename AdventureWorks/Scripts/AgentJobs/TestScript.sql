-- Change context to MSDB for the SQL Server Agent Job creation

use msdb
go

-- If the EMISGroupDBA - Audit job already exists, drop it.

if exists (select job_id from dbo.sysjobs_view where name = N'EMISGroupDBA - Audit') begin
	execute dbo.sp_delete_job
		@job_name = N'EMISGroupDBA - Audit',
		@delete_unused_schedule = 1;
	end
go

-- Declare a dynamic variable.

declare @jobId binary (16);

-- Create the EMISGroupDBA - Audit job

execute msdb.dbo.sp_add_job
	@job_name = N'EMISGroupDBA - Audit',
	@enabled = 1,
	@notify_level_eventlog = 0,
	@notify_level_email = 2,
	@notify_level_netsend = 2,
	@notify_level_page = 2,
	@delete_level = 0,
	@description = N'Job to initiate and maintain Audit information.',
	@category_name = N'[Uncategorized (Local)]',
	
	@job_id = @jobId output;
go

-- Map the EMISGroupDBA - Audit job to the local server instance.

execute msdb.dbo.sp_add_jobserver
	@job_name = N'EMISGroupDBA - Audit',
	@server_name = N'(local)';
go

-- Declare a dynamic variable for the job step's Powershell command.

declare @PowershellCommand nvarchar (max) = N'$CurrentDirectory = Get-Location
$EventTargetDirectory = "C:\EMISGroupDBA\' + @@servicename + N'"
if (! $CurrentDirectory.Equals("C:\")) {
	cd "C:"
	cd "C:\"
	if ((Test-Path $EventTargetDirectory) -eq 0) {
		mkdir $EventTargetDirectory
		cd $EventTargetDirectory
	}
}';

-- Create the Create Extended Event Directory step with the above powershell command.

execute msdb.dbo.sp_add_jobstep
	@job_name = N'EMISGroupDBA - Audit',
	@step_name = N'Create Extended Event Directory',
	@step_id = 1,
	@cmdexec_success_code = 0,
	@on_success_action = 3,
	@on_fail_action = 2,
	@retry_attempts = 0,
	@retry_interval = 0,
	@os_run_priority = 0,
	@subsystem = N'powershell',
	@command = @PowershellCommand,
	@database_name = N'master',
	@flags = 0;
go

-- Create the Create Extended Event Sessions step.

execute msdb.dbo.sp_add_jobstep
	@job_name = N'EMISGroupDBA - Audit',
	@step_name = N'Create Extended Event Sessions',
	@step_id = 2,
	@cmdexec_success_code = 0,
	@on_success_action = 3,
	@on_fail_action = 2,
	@retry_attempts = 0,
	@retry_interval = 0,
	@os_run_priority = 0,
	@subsystem = N'TSQL',
	@command = N'execute Audit.CreateExtendedEventSessionsAndDirectories;
go',
	@database_name = N'EMISGroupDBA',
	@flags = 0;
go

-- Create the Collect Audit Data from Extended Event Sessions step.

execute msdb.dbo.sp_add_jobstep
	@job_name = N'EMISGroupDBA - Audit',
	@step_name = N'Collect Audit Data from Extended Event Sessions',
	@step_id = 3,
	@cmdexec_success_code = 0,
	@on_success_action = 3,
	@on_fail_action = 2,
	@retry_attempts = 0,
	@retry_interval = 0,
	@os_run_priority = 0,
	@subsystem = N'TSQL',
	@command = N'execute Audit.CollectExtendedEventData;
go',
	@database_name = N'EMISGroupDBA',
	@flags = 0;
go

-- Declare a dynamic variable for the job step's Powershell command.

declare @PowershellCommand nvarchar (max) = N'$limit = (Get-Date).AddMinutes(-15)
$path = "C:\EMISGroupDBA\' + @@servicename + N'"
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force';

-- Create the Remove processed Extended Event Files step with the above powershell command.

execute msdb.dbo.sp_add_jobstep
	@job_name = N'EMISGroupDBA - Audit',
	@step_name = N'Remove processed Extended Event Files',
	@step_id = 4,
	@cmdexec_success_code = 0,
	@on_success_action = 3,
	@on_fail_action = 2,
	@retry_attempts = 0,
	@retry_interval = 0,
	@os_run_priority = 0,
	@subsystem = N'powershell',
	@command = @PowershellCommand,
	@database_name = N'master',
	@flags = 0;
go

execute msdb.dbo.sp_add_jobstep @job_name = N'EMISGroupDBA - Audit',
	@step_name = N'Check and Set Patching Permissions',
	@step_id = 5,
	@cmdexec_success_code = 0,
	@on_success_action = 1,
	@on_fail_action = 2,
	@retry_attempts = 0,
	@retry_interval = 0,
	@os_run_priority = 0,
	@subsystem = N'TSQL',
	@command=N'execute Audit.GrantPatchingPermissionsInMaintenanceWindow;
go',
	@database_name=N'EMISGroupDBA',
	@flags=0;
go

-- Update the job to use SA as the owner, with emails to the operator on failure if set-up to do so.

if not exists (select name from msdb.dbo.sysoperators where name = N'SQL Job Failure') begin
	execute msdb.dbo.sp_update_job
		@job_name = N'EMISGroupDBA - Audit',
		@enabled = 1,
		@start_step_id = 1,
		@notify_level_eventlog = 0,
		@notify_level_email = 2,
		@notify_level_netsend = 2,
		@notify_level_page = 2,
		@delete_level = 0,
		@description = N'Job to initiate and maintain Audit information.',
		@category_name = N'[Uncategorized (Local)]',
		
		@notify_netsend_operator_name = N'',
		@notify_page_operator_name = N'';
end
else if exists (select name from msdb.dbo.sysoperators where name = N'SQL Job Failure') begin
	execute msdb.dbo.sp_update_job
		@job_name = N'EMISGroupDBA - Audit',
		@enabled = 1,
		@start_step_id = 1,
		@notify_level_eventlog = 0,
		@notify_level_email = 2,
		@notify_level_netsend = 2,
		@notify_level_page = 2,
		@delete_level = 0,
		@description = N'Job to initiate and maintain Audit information.',
		@category_name = N'[Uncategorized (Local)]',
		
		@notify_email_operator_name = N'SQL Job Failure',
		@notify_netsend_operator_name = N'',
		@notify_page_operator_name = N'';
end
go

-- Declare a dynamic varable for the Schedule ID.

declare @schedule_id int;

-- Add a default job schedule.

execute msdb.dbo.sp_add_jobschedule
	@job_name = N'EMISGroupDBA - Audit',
	@name = N'EMISGroupDBA - Audit',
	@enabled = 1,
	@freq_type = 4,
	@freq_interval = 1,
	@freq_subday_type = 4,
	@freq_subday_interval = 15,
	@freq_relative_interval = 0,
	@freq_recurrence_factor = 1,
	@active_start_date = 20160525,
	@active_end_date = 99991231,
	@active_start_time = 0,
	@active_end_time = 235959,
	@schedule_id = @schedule_id output;
go