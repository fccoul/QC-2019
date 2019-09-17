cls
$logs=Get-Eventlog -list | Get-Member -MemberType Properties 
$logs
$logs=Get-Eventlog -list |select LogDisplayName |
Out-GridView -title "Select one or more logs" -OutputMode Multiple
$count=1,10,25,50 | Out-GridView -title "How many entries ?" -OutputMode Single
$printer=get-printer | Select name | Out-GridView -Title "Select a printer" -OutputMode Single
$logs | foreach {
$_.logDisplayName
Get-eventlog -LogName $_.logDisplayName -newest $count -EntryType Error |
Select Timegenerated,Source,Message | format-List |
Out-Printer $printer.Name  
}
cls
#tee-Object
Get-process | sort ws -Descending | select -first 10 | Tee-Object -FilePath "\\AHOMEDIRPNAS\Homedirp\CCO148\Test PS\proc.txt"
#or with print
cls
Get-process | sort ws -descending | select -first 10 | Tee-Object -FilePath "\\AHOMEDIRPNAS\Homedirp\CCO148\Test PS\proc.txt" | Out-printer $printer.Name
Invoke-Item H:\document.pdf

#pipeline in Depth
cls
help restart-service -parameter name
'bits','winrm' | restart-service -passThru  
help restart-service -parameter inputobject
get-service winrm | restart-service -passThru
#getting bug and display screen -Host
Trace-command -name ParameterBinding -Expression {get-service winrm | restart-service} -PSHost

help Test-NetConnection -parameter computername
get-content "\\AHOMEDIRPNAS\Homedirp\CCO148\Test PS\computer.txt"

get-content "\\AHOMEDIRPNAS\Homedirp\CCO148\Test PS\computer.txt" | Test-NetConnection -InformationLevel Detailed

Test-NetConnection

import-csv "C:\Users\CCO148\scripts\All Courses.csv"

Get-Process | Get-Member -MemberType Properties
Get-Process | Select ID,Name,WS,Starttime, 
@{Name='Runtime';Expression={(Get-Date) - $_.starttime}}

Get-Process | sort cpu -Descending |
select -first 10 -Property ID,Name,CPU,StartTime,
@{Name="Runtime";Expression={(Get-Date) - $_.starttime}}

get-service bits -computername P0TB2 | select *
get-service bits -ComputerName p0tb2 |SELECT Displayname,status,
@{Name="computername";expression={$_.machinename}} | Out-GridView -Title "Services"

dir -path H:\ZGJW011 -file -recurse | SELECT Name,
@{Name="SizeKB";Expression={[math]::Round($_.length/1Kb,2)}},
@{name="Modified";Expression={$_.lastWritetime}},
@{Name="ModifiedAge";Expression={(Get-Date)-$_.lastwritetime}},
@{Name="Path";Expression={$_.fullname}},
@{Name="ComputerName";expression={$env:COMPUTERNAME}}

Get-Service winrm | Select -ExpandProperty RequiredServices #get value of object instead object itself
Get-Service winrm | Select  RequiredServices

(get-service | where status -EQ running).DisplayName | sort | more


Get-EventLog application -EntryType Error,Warning | Group Source | foreach {
$file = Join-Path -Path "H:\Test PS" -ChildPath "$($_.name).txt"
"$($_.count) entries" | out-file -filepath $file
$_.group | foreach {
$_ | Select TimeGenerated,EntryType | Out-file -FilePath $file -Append
$_ | Select -Expandproperty Message | Out-file -filePath $file -Append #provides more details...
#$_ | Select  Message | Out-file -filePath $file -Append
}
Get-Item $file

}

notepad "H:\Test PS\Application hang.txt"
 
# PowerShell format :descibes path conatins : DotnetTypes.format.ps1xml -->defaults and alternate layouts of powershell
$PSHOME
get-service bits
get-service bits | Get-Member name
dir $pshome\DotnetTypes.format.ps1xml
Get-Content $pshome\DotnetTypes.format.ps1xml
Get-Content $pshome\DotnetTypes.format.ps1xml | SELECT-string system.servicecontroller -context 0,30 | more
Get-Service bits | ft
Get-Service bits | fl
dir "H:\Test PS\*.txt" | format-table -Property Fullname,length,lastwritetime

dir "H:\Test PS\*.txt" | format-table -property fullname,Name,
@{Name="Size";Expression={$_.length}},lastwritetime,
#@{Name="Age(days)";Expression={(Get-Date)-$_.lastwritetime | Select Totaldays}}
@{Name="Age(days)";Expression={(Get-Date)-$_.lastwritetime | Select -ExpandProperty Totaldays}}

dir "H:\ZGJW011" -file -recurse | Group Extension |
Select Count,Name,
@{Name="TotalKB";expression={$_.group | measure length -sum | select -ExpandProperty sum}} |
format-table -group Name -Property Count,TotalKB


get-alias -definition Format-table

Get-NetAdapter
Get-netadapter | ft -AutoSize #redimensiosnment des colonnes for best looking
Get-Eventlog application -newest 5  | ft Timegenerated,Source,EntryType,Message -Wrap
Get-Eventlog application -newest 5  | ft Timegenerated,Source,EntryType,Message -Wrap | ft -Wrap

get-process  -IncludeUserName

get-process | format-table -View priority
get-process | Format-Table -view foo #this generated an error wit for know a various allowed paramegters for cmdlet --here : get-process
get-process | format-table -view starttime
get-process | sort starttime | format-table -View starttime
get-service | format-table -view foo #this generated an error wit for know a various allowed paramegters for cmdlet --here : get-service
get-service | format-table -view service

get-alias -definition format-list
get-eventlog application | select -first 1| fl * # fl * : excelent way for get all properties and values of item in collection or an object
dir C:\Windows\System32\wdi\*.dat | format-list -view foo #will generate error ,since we willl get all properties - wit

help format-wide
get-alias -definition format-wide
get-eventlog application | select -first 2 | fw
get-eventlog application | select -first 5 | fw
get-eventlog application | select -first 5 | fw -colum 4 #display on many coluns
get-service | format-wide -autosize #display column outfit
get-service | fw Displayname -AutoSize #specify a specific column

dir c:\windows -Directory | fw -AutoSize
dir c:\windows -Directory | fl *
dir c:\windows -Directory | sort Name -Descending | fw -AutoSize

dir "H:\ZGJW011" | sort extension | fw -GroupBy extension -AutoSize
dir "H:\ZGJW011" | sort {$_.GetType().Name} | fw -Groupby {$_.GetType().Name} -AutoSize

help format-custom
get-alias -Definition  format-custom
get-service | fc
get-process powershell | fc
get-process powershell | fc -Property *
