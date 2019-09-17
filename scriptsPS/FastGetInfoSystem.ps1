$PSVersionTable  
Get-NetIpAddress 
gsv -ComputerName P0TB2 
(get-Ciminstance win32_Physicalmemory -ComputerName P0TB2).Capacity 
get-CimInstance win32_Physicalmemory -ComputerName P0TB2
(((get-Ciminstance win32_Physicalmemory -ComputerName P0TB2).Capacity | measure -Sum).Sum)
Get-WmiObject -class Win32_logicaldisk
(get-Ciminstance Win32_OperatingSystem -ComputerName $ComputerName ).caption
hostname
##############################################################
$env:COMPUTERNAME=read-host 'Enter name of host'
$StoppedService=get-service -ComputerName $env:COMPUTERNAME
                    Where-Object -Property Status -eq 'Stopped'
Write-Output $StoppedService

##############################################################
#use cmdlet WMI/CIM for get info free space disk...etc
