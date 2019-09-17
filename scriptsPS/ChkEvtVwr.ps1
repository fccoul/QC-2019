Get-EventLog -LogName System -EntryType Error -Newest 10 | Select Time,Source,message
Get-EventLog -LogName System -EntryType Error -Newest 1| Get-Member
Get-EventLog -LogName System -EntryType Error -Newest 10 | Select TimeGenerated,Source,message 
Get-EventLog -LogName Application -EntryType Error -Newest 3 | Select TimeGenerated,Source,message | format-list