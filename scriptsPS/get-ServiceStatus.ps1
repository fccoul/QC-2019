#get-ServiceStatus.ps1 - Script displays the status of services running on a specified machine

#Creates a mandatory parameter for computername and for Service Status

param(
[parameter(Mandatory=$true)]
[string[]]                   #additional[] after string denotes this parameter accepts multiples inputs
 $computername               #Note this is the same name as th variable used in your code below
 )

 #creates a variable for get-Service Objects
 #As it can hold multiple objects , referred to as an array
 $Services=Get-Service -ComputerName $computername

 #use Foreach construct to perform actions on each object in $Services
 Foreach ($service in $Services){
 
 
 #create varaible containing status ans displayname using member enumertaion
 $ServiceStatus=$Service.Status

 #decimal notating the varaible al;lows access to porperties of each object
 $ServiceDisplayName=$service.DisplayName

 #use if-else construct for decision making

 if($ServiceStatus -eq 'Running')
 {
  Write-Output "Service OK - Status of $ServiceDisplayName is $ServiceStatus"
 }
 else
 {
    Write-Output "Check Service - Status of $ServiceDisplayName is $ServiceStatus"
 
 }
 }

