cls
function Prevent-IseExecution()
{
<#
   .Synopsis
   Prevents a script from executing any further if it's  in the ISE

   .Description
   The function determines wether it's running in the ISE or a Window,
   if it's in the ISE it breaks,causing further execution of the script to halt.
#>

#If we're in the PowerShell ISE,there will be a special varaible
#named $PsIse. If it's null,then we're in the command prompt
    if($psise -ne $null)
    {
      " You cannot run this script inside the PowersHELL ise . pLEASE EXECUT IT FORM THE pOWERsHELL cOMMAND WINDOW "
      break # the break will bubble back up to the parent
    }
} 

#Stop the user if we're in the ISE
Prevent-IseExecution

#Code Will only continu if we're in command prompt
"I must not be in the ISE"