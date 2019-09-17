#basic script to view stopped services om a system
$env:COMPUTERNAME=read-host 'Enter name of host'
$StoppedService=get-service -ComputerName $env:COMPUTERNAME
                    Where-Object -Property Status -eq 'Stopped'
Write-Output $StoppedService

