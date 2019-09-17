<#
.Synopsis
   this is a script to gather information for help desk support calls

.Description
   this a basic script designed to gather user and computer information for helpdesks support calls.
   information gathered includes:
   DNS Name & IP address
   DNS Server
   Name of OS
   Amount of memory in target computer
   Amount of free space on disk
   last reboot of System

.Example
   Get-Support
   PS C:\....CCo148> .\ScriptTask.ps1

       cmdlet ScriptTask.ps1 at command pipeline position 1
       supply values for the following parameters :
       ComputerName : $ComputerName
       Username : cco148

       in this example, the script is simply run and the parameters are input as they are mandatory
.Example
    ...
#>

#Scripts.Task.ps1
#Franck COULIBALY
#Created : August 22,2019
#Updated:  August 23,2019
#updates: cleaned up code, removed unused commands
#References

##parameters for ComputerName & UserName
param(
[parameter(Mandatory=$true)][string]$ComputerName 
 )

#variables
$Credential=get-Credential
$CimSession=New-CimSession -ComputerName $ComputerName -Credential $Credential
$Analyst=$Credential.UserName

#Commands

#OS Description
$OS=(get-Ciminstance Win32_OperatingSystem -ComputerName $ComputerName ).caption
#$OS

#Disk Freesapce on OS Drive
$drive=Get-WmiObject -class Win32_logicaldisk | Where-Object DeviceID -EQ 'C:'
$Freespace=(($drive.Freespace)/1gb)
#$drive
#$Freespace

#Amount of System Memory
$MemoryInGB = ((((get-Ciminstance Win32_PhysicalMemory -ComputerName $ComputerName ).Capacity | measure -Sum).Sum)/1gb)
#$MemoryInGB

#Last Reboot System
$lastReboot=(get-CimInstance -Class Win32_OperatingSystem -ComputerName $ComputerName ).LastBootUpTime
#$lastReboot


#IP Address & DNS Name
$DNS=Resolve-DnsName -Name P0TB2 | Where-Object Type -EQ "A"
$DNSName=$DNS.Name
$DNSIP=$DNS.IPaddress
$Ipinfo=Get-CimInstance win32_netWorkAdapterConfiguration
#$DNS
#$DNSName
#$DNSIP


#DNS Server of Target
#$CimSession=$CimSession -ComputerName $ComputerName  -Credential ($Credential)
$DNSSErver=(get-DNSClientServerAddress -cimsession $CimSession -InterfaceAlias "ethernet" -AddressFamily Ipv4).ServerAddresses

#Write Ouput to screen
#Clear-Host
Write-Output "help Desk Support Information for $ComputerName"
Write-Output "-----------------------------------------------"
Write-Output "Support Analyst: $Analyst";""
Write-Output "Computername : $Computername";""
Write-Output "Last system Reboot of $computername : $lastreboot";""
Write-Output "DNS Name of $computername : $DNSName";""
Write-Output "IP Address of $DNSName : $DNSIP";""
Write-Output "DNS Server(s) for $ComputerName : $DNSServer";""
Write-Output "Total System RAM in $computername : $memoryInGB GB";""
Write-Output "Freespace on C: $Freespace GB";""
Write-Output "Version of Operating System: $OS"
