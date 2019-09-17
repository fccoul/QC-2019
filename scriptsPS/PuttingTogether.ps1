#------------------------------------------------------------------------------------------------
#-----User Intergaces and Input
#------------------------------------------------------------------------------------------------
 
Import-module "C:\Users\CCO148\scripts\PuttuingItAllTogetehr_Functions.ps1"

$title="Pick something really cool"

$menu=@"
     1. Pluralsight
     2. Arcane Code
     3. Bow ties
     4. Fezzes
     5.Bugatti Veyrons
"@

Set-AppColors
Clear-Host
Display-AppHeader $title
$menu

$choice=Read-Host -Prompt "Select a Menu option "

Write-Host
Write-Host "You Thought number $choice was really cool! "
Write-Host
$reason=Read-Host -Prompt "What makes you think that ?"

Write-Host
Write-Host "Oh, so you think ""$reason"" is a good reason. Interesting. lets save that for later !"

$file=Read-Host -prompt "Enter a file name to save it to, or just hit enter to not save it"
if($file.Length -gt 0)
{
  Write-TxtFile $file $reason # -debug # Add - debug to display de bugging aids
}
else
{
   "You chose not to save your  reason. pity ,It was a good one. "
}
