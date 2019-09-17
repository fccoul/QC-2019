cls
help about_Jobs
get-command -noun job  #| fw -AutoSize

#start job
start-job -ScriptBlock {get-service} | tee -variable j
$net=start-job {netstat -an}
$net
start-job {dir $env:temp -file -Recurse | measure length -Average} -Name tempsize
start-job {Param($status) get-service | where status -EQ $status} -name svc -ArgumentList @('running')
help  Start-Job -parameter filepath

"C:\Users\CCO148","C:\PerfLogs",$env:temp | foreach{
start-job -filepath C:\Users\CCO148\scripts\ScriptsTask.ps1 -name Report -ArgumentList $_
}
start-job {get-content Pluaralsight.xml | select-string 'Expert'} -Name Exporto

#simulate fail
start-job {get-foo} -name foo

#retrieve results
help Get-Job
#1.get jobsin current session
Get-Job
Get-job tempsize
Get-Job -State Running
Get-Job -State Completed
Get-Job -State failed
Get-Job | group state
Get-Job tempsize -IncludeChildJob

$net | receive-job
$j | receive-job

#2 : receive : after get results , it disappears -->hasmoredata set to false
receive-job $j | get-member
$j
receive-job -Name svc
Get-job svc
receive-job  -Name svc | get-member
#for conserve result into session
receive-job tempsize -keep
receive-job tempsize -keep | get-member
Receive-Job svc -keep | select -first 3 |fl

help wait-job
start-job {1..10 | foreach {$_;sleep -milliseconds 1000}} -name n
get-job n | wait-job
get-job n | wait-job  | receive-job -keep

help remove-job # works only task done
Get-Job
remove-job -state failed
remove-job n
# remove-job -Id 14
get-job | remove-job #remove all job done  in current session

help Invoke-Command -Parameter asjob
hostname
invoke-command -scriptblock {Get-EventLog -list | where {$_.Entries.Count -gt 0 }} -computerName POTB2 -AsJob
get-job
get-job | wait-job | receive-job -keep
$t=invoke-command -FilePath C:\Users\CCO148\scripts\get-Memory.ps1 -ArgumentList C:\Windows\Temp -ComputerName P0TB2 -AsJob
get-job 
$t #display info Job
receive-job $t #display result job
$a=invoke-command -scriptblock  {param([string]$svc) get-service $svc} -computername P0TB2,foo,bar -AsJob -ArgumentList 'bits'
$a
$a | get-job -IncludeChildJob
$a | receive-job -keep

#tips : even job's state is failed ,it doesn't mean all treatments are failed, so for ensure check always childJob 

help get-wmiobject -param asjob
get-wmiobject -class win32_process -AsJob
get-job -newest 1
#WMI: Windows Management Instrumentation
$b=get-wmiobject win32_service -computerName P0TB2,foo -AsJob
$b | Wait-Job | receive-job -keep | select -last 5 | format-table

start-job {Get-CimInstance win32_volume -computername P0TB2,foo} -name voljob
wait-job voljob | receive-job -keep
 

 