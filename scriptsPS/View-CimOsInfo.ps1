$env:COMPUTERNAME=Read-Host "Yo man entre Computername"
get-CIMInstance -class Win32_OperatingSystem -computerName $env:COMPUTERNAME |
Select-Object -Property CSName,latBootUpTime