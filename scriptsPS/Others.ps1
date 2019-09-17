#Set-Localation will change the current path
Set-Location \\AHOMEDIRPNAS\Homedirp\CCO148\ZGJW011
#pipelining - combine cmdlets for power
Get-ChildItem | Where-Object {$_.Length -gt 100kb} | Sort-object length 
#ou ceci
#Get-ChildItem | Where{$_.Length -gt 100kb} | Sort-object length 
#multiple criteria
#Get-ChildItem | Where{$_.Length -gt 100kb -and $_.Name -like "*e*"} | Sort-object length 
#ou
#Get-ChildItem | Where-Object -property Length -gt 100kb | Sort-object length 
#ex with property boolean (isroot) avec negation
#get-vegetable | Where {-not($_.isroot)} | select name,isroot 
#or this #get-vegetable | Where {$_.isroot -eq $False} | select name,isroot 
#get-vegetable | where {$_.isroot -OR $_.color -eq 'green'} | select name,isroot

#cmdlets on multi line for  read
Get-ChildItem |
  Where-Object{$_.Length -gt 100kb} |
  Sort-Object length -Descending

#To specify column in the output and get nice formatting , use Format-table
Get-ChildItem |
   Where-Object {$_.Length -gt 100kb} |
   Sort-Object length |
   Format-Table -Property Name,Length  -AutoSize

#use Select-Object to retrieve certain paroperties from an object
Get-ChildItem | Select-Object Name,Length

#Providers
Get-PSProvider
Get-PSDrive
Get-PSSnapin
# Load the SQL Server add-ins
#Add-PSSnapin SqlServerCmdletSnapin100
#Add-PSSnapin SqlServerProviderSnapin100

#Get-PSSnapin -Name "Sql*"
Get-PSSnapin | Select-Object Name
Get-PSDrive

#programming
[System.int32]$myint=42 #can make strongly typed variables
$myint
$myint.GetType()

#$myint="this won't work"

"Pluralsight Rocks".GetType()
#Accessing methods on objects
"Pluralsight Rocks".ToUpper()
"Plurialsight Rocks".ToLower().Contains("plu")

#Comparaison
$var=42
$var -gt 40
$var -lt 40
$var -ge 42
'jeff' -eq 'JEFF'
'jeff' -ceq 'JEFF'
'JEFF' -ceq 'JEFF'
'jeff' -notlike 'je*'
'jeff' -match "^J"
'srv03' -match "\w+\d{1,3}"

# Calculations are like any other language
$var=3*110
$var
$var++
$var
$var -eq 42

# variables
Set-Variable -name VarTest -Value 789
$Vartest

# Clear the contents of a variable
# Same as $var=$null
Clear-Variable -name VarTest
$Vartest
# wipe out a variable
Remove-Variable -Name VarTest
$Vartest

#Esacpe squences - use the backtick
#newline 'n
"Plural `nsight"
#bacspace `b`"plural `bsight"#carriage return `r
"plural `rsight"

"plural `r`nsight"
#tabs
"Plural `tsight"
#text multi-lines
$hereText=@"
Some text here
Some more herer
     a bit more
a blank line above
"@

$hereText

#String Interpolation
set-Location \\AHOMEDIRPNAS\Homedirp\CCO148\Integration
Clear-Host
$items=(Get-childItem).Count
$loc=get-location
"There are $items are in the folder $loc"
#To actually display the varaible,  escape it with a backtick
"There are `$items items are in the folder `$loc."
#or one quote
'There are $items items are in the folder $loc.'
#interpolation more
$hereInterpolation=@"
Items `tfolder
------`t-------------------------------
$items`t`t$loc
"@
$hereInterpolation
#Can use expressions in strings, need to wrapped in $()
"There are $((Get-ChildItem).Count) items are in the folder $(Get-Location)."

"the 15% tip of a 33.33 dollar bill is $(33.33*0.15) dollars"

#string Formatting like c#
[string]::Format("Man ! there are {0} items",$items)
#Same to do  powershell shortcut
"Shell There are {0} items." -f $items
"Shell There are {0} items in the location {1} ." -f $items,$loc

#wildcard
cls
"Pluralsight" -like "Plural*"
"Pluralsight" -like "arcane*"
"Pluralsight" -like "?luralsig?t" #question marks work for single characters
"Pluralsight" -like "Plural*[s-v]" #ends in a char between s and v
"Pluralsight" -like "Plural*[a-c]" #ends in a char between a and c

#regular expressions
cls
"888-368-1234" -match "[0-9]{3}-[0-9]{3}-[0-9]{4}" #phone number
"888.368.1234" -match "[0-9]{3}-[0-9]{3}-[0-9]{4}" #phone number

#arrays
cls
$array="arcane","code",45
$array[0]
$array[2] 
$array
$array.GetType()
$arrayBarc=@("allo","ici","kpleus")
$arrayBarc.GetType()
$arrayBarc
$arrayEmpty=@() #only way to create an empty array
$arrayEmpty.Count
#updating array
$array="tommy","hiro"

$array
$array[0]="josh"
$array
$array=12..26 #can load arrays using numeric range notation
$array

#check  to see if an item exists
Clear-host
$numbres=1,42,256
$numbres -contains 42
$numbers -notcontains 99
$numbres -notcontains 42

#HASH Table
$hash=@{"key"="value";
        "pluralsight" = "pluralsight.com"
        "arcane code"="arcanecode.com"}

$hash
$hash["Pluralsight"]
#using avriables as keys
$mykey="Pluralsight"
$hash.$mykey
$hash.$($mykey)
#Adding and removing values
$hash["To gear"]="topgear.com"
$hash
$HASH.Remove("Arcane code")
$hash
#see if key exists
$hash.Contains("Arcane mode")
$hash.Keys -contains "Arcane mode"  #OR same result 2 methods
# see if value exists
$hash.ContainsValue("pluralsight.com")
$hash.Values -contains "pluralsight.com"
#lising
$hash.Keys
$hash.Values


$host
$PSversiontable
#------------------------------------------------------------------------------------#
#branching
#------------------------------------------------------------------------------------#
Clear-Host
$var=4
if($var -eq 1)
{
    cls
    "if -eq 1 branch"
}
else
{
    if($var -eq 2)
    {
        cls
        "if -eq 2 branch"
    }
    else
    {
        Clear-Host
        "else else branch"
    }
}

Cls
$var=42
switch($var)
{
 41 {"Forty One"}
 42 {"Forty Two";break}
 "42" {"Forty Two string"}
 43 {"Forty Three"}
 default {"Defasult amn"}
}

Switch(3,1,2,42)
{
1{"One"}
2{"Two"}
3{"Three"}
default{"The default answer"}
} 

#sensitive case
Switch -casesensitive ("PluralSight")
{
"pluralsight" {"lowercase"}
"PLURALSIGHT" {"uppercase"}
"PluralSight" {"mixedcase"}
}

#supports wildcards
cls
switch -Wildcard ("Pluralsight")
{
   "plural*" {"*"}
   "??ural"{"??"}
   "Pluralsi???" {"???"}
}

#----------------------------------------------------------------------------------------------------#
#looping
#----------------------------------------------------------------------------------------------------#
#while
cls
$i=1
While($i -le 5)
{
 "`$i=$i"
 $i=$i+1
}
#Do
Cls
$i=1
do
{
"`$i=$i"
$i++
}while($i -le 3)
#for
cls
for($f=0;$f -le 5;$f++)
{
 "`$f=$f"
}
cls
$f=2 #the initializer can be set separately
for(;$f -le 5;$f++)
{
"`$f=$f"
}
cls
$array=11,12,13,14,15,16
for($i=0;$i -lt $array.Length;$i++)
{
"`$array[i]=$i"
}
#foreach 
clear-host
foreach($item in $array)
{
"`$item=$item"
}
set-Location \\AHOMEDIRPNAS\Homedirp\CCO148\Integration
#Get-ChildItem
foreach($file in Get-ChildItem)
{
$file.Name
}
foreach($file in Get-ChildItem)
{
   if($file.Name -like "*.txt")
   {
     $file.Name
     break
     #continue
   }
}
foreach($item in 1..7)
{
"`$item=$item"
}
#--------------------------------------------------------------------------------------------#
#-Script Block-------------------------------------------------------
#--------------------------------------------------------------------------------------------#
$cool={clear-host; "Powershell is cool"}
$cool
& $cool #"&  can iterprerte and  execute le code"
$value={41+1}
&$value
1+(&$value)
#parameters 1 : using the args collection
$qa={
$question=$args[0]
$answer=$args[1]
write-host "here is your question : $question the answer is $answer"
}
&$qa "What is cool " "Powershell!"
#parameters2 : a more readable method - using the param block
$qa={
     param($question,$answer)
     Write-Host "here is your question : $question `nThe answer is $answer"
}

&$qa "What else is cool ?" "basket"
#arguments with names
&$qa -answer "soccer" -question "What sport next ?"
#arguments with shortcut
&$qa -a "Bugattin veyron" -q "is anything else cool ?"
#check empty value
cls
$qa={
   param($question, $answer)
   if(!$answer){
      $answer="Error : You must give an answer"
   }
   Write-Host "here is your question : $question `nthe answer is $answer"
}
&$qa -q "who is kpleus ?" -a "a rich man"
#with default value
cls
$qa={
   param($question, $answer="a rich man !")
   
   Write-Host "here is your question : $question `nthe answer is $answer"
}
&$qa "who is kpleus ?"  

#explicit typing on parameters
cls
$math={
param([int]$x,[int]$y)
return $x * $y
}

&$math 3 12
#pipeline
$onlyCoolFiles={
process {
        if($_.Name -like "*.txt")
           {return $_.Name}
    
    }
}
cls
Get-ChildItem | &$onlyCoolFiles
#pipeline with traitment before and after
$onlyCoolFiles={
  
  begin {$retval="here are some cool files : `r`n"}
  
    process {
                if($_.Name -like "*.pdf")
                    {$retval=$retval+ "`t" +$_.Name+"`r`n"}
            }
   end {return $retval}
  
}
cls
Get-ChildItem | &$onlyCoolFiles

#----------------------------------------------------------------------------------------
#------------------Varaible scope--------------------------------------------------------
#----------------------------------------------------------------------------------------
Clear-Host
$var=42
&{$var=33; Write-Host "insible bloc :$var"}
Write-Host "Outside block :$var"
#Displaying variables is a shortcut to get-variable
Get-Variable var
Get-Variable var -ValueOnly #display opnly value

#scope current : 0 , 1 it's parent ,2 grandparent and so on
cls
$var=42
&{
$var=33
Write-Host "Inside block : $var"
Write-Host "Parent : " (Get-Variable var -ValueOnly -Scope 1)}
Write-Host "Ouside block:  $var"
 
#Using Set-variable with Scope you can change values outside a block
cls
$var=42
&{
Set-Variable var 33 -scope 1
Write-Host "Inside block : $var"
}
Write-Host "Outside block: $var"

#making it global variable
cls
$Global:var=44
&{$Global:var = 32}
Write-host "Ouside block : $global:var"

#On the reverse side, private makes it very private
cls
$Private:unmentionables = 42
&{ Write-Host "Oustside bloc:$private:unmentionables" #will be null
   if($unmentionables -eq $null)
    {Write-Host "I can't show you my `$unmentionables, they are null."}
} 
Write-Host "Outside block : $private:unmentionables"
#--------------------------------------------------------------------------------------------
#-------------PowerShell Advanced------------------------------------------------------------
#--------------------------------------------------------------------------------------------
function Get-Fullname($firstNAme,$lastName)
{
Write-Host($firstNAme+ " " +$lastName)
}

Get-Fullname "Arcane" "Code"

function get-CoolFiles()
{
    begin{$restval="Here are some cool files : `r`n"}
    process{
         if($_.Name -like "*.txt")
             {$retval=$restval + "`t"+$_.Name+"`r`n"}
         }
    end{return $retval}
}
cls
Get-ChildItem | get-CoolFiles
#filter
filter show-pdfFiles{
  $filename=$_.Name
  if($filename -like "*.pdf")
  {
  return $_
  }
}
clear-host
Get-ChildItem |show-pdfFiles
function List-FileNames()
{
    begin {$retval="here are some files pdf : `r`n"}
    process { 
            $retval=$retval + "`t"+$_.Name+"`r`n"
            }
    end {return $retval}

}

Get-ChildItem | show-pdfFiles| List-FileNames

#Having your function output to the pipeline
Clear-Host
Set-Location "\\AHOMEDIRPNAS\Homedirp\CCO148\ZGJW011"
Get-ChildItem | Select-Object "Name"

function Get-ChildName()
{
  write-output (Get-Childitem | select-object "Name")
}

Get-ChildName | Where-Object {$_.Name -like "*.png"}

#supporting -verbose and -debug options
#To support , fisrt need to change the values of the sepcail variables :
#$DebugPreference    Default is SilentlyContinue, change to continue
#$VerbosePreference  default is SilentlyContinue, change to continue

function Get-ChildNameVerboseDebug()
{
   param([switch]$verbose,[switch]$debug)
   
   if($verbose.IsPresent)
   {
      $VerbosePreference="Continue"
   }
   else
   {
      $VerbosePreference="SilentlyContinue"
   }
   
   if($debug.IsPresent)
   {
      $DebugPreference="Continue"
   }
   else
   {
      $DebugPreference="SilentlyContinue"
   }

   Write-Verbose "Current working location is $(Get-Location)"
   Write-Output (Get-ChildItem | Select-Object "Name")
   Write-Debug "OK I've selected some."
}

Get-ChildNameVerboseDebug
Get-ChildNameVerboseDebug -verbose
Get-ChildNameVerboseDebug -debug
Get-ChildNameVerboseDebug -verbose -debug

#help
function get-ChilNameH()
{
 <#
  .SYNOPSIS
  Retuns a list of only the names for the cild items in the current location

  .DESCRIPTION
  this function is similar to Get-ChildItem, execpt that it retuns only the name property

  .INPUTS 
  Nome.

  .OUTPUTS
  System.string . Send a collection of string out pipeline.

  .EXAMPLE
  Example1  -Simple use
  Get-ChildNameH

  .EXAMPLE
  Example2 - Passing to another object in the pipeline
   Get-ChildNameH | Where-Object {$_.Name -like "*.ps1"}

   .LINK
    Get-ChildItem
   
 #>

 Write-Output (Get-ChildItem | Select-Object "Name")
}

cls
Get-Help get-ChilNameH -Examples
Get-Help get-ChilNameH -full
Set-Location "\\AHOMEDIRPNAS\Homedirp\CCO148\ZGJW011"
get-ChilNameH  | Where-Object {$_.Name -like "*.png"}

#-------------------------------------------------------------------------------------------#
#--------Error Handling----------------------------------------------------------------------
#-------------------------------------------------------------------------------------------#
function divver($enum,$denom)
{
    Write-Host "Divver begin."
    $result=$enum/$denom
    Write-Host "Result : $result"
    Write-Host "Divver done."
}
Clear-Host
divver 33 11
divver 33 0
Clear-Host
function divver($enum,$denom)
{
    Write-Host "Divver begin."
    $result=$enum/$denom
    Write-Host "Result : $result"
    Write-Host "Divver done."

    trap{
    Write-Host "Oh NO ! An Error has occured !!"
    Write-Host $_.ErrorID
    Write-Host $_.Exception.Message
    continue  #Continue will continue with the next line of code after the error
    }
}

divver 33 0
cls
function divver($enum,$denom)
{
    Write-Host "Divver begin."
    $result=$enum/$denom
    Write-Host "Result : $result"
    Write-Host "Divver done."

    trap{
    Write-Host "Oh NO ! An Error has occured !!"
    Write-Host $_.ErrorID
    Write-Host $_.Exception.Message
    break  #with break, or omitting it,error bubbles up to parent
    }
}

divver 33 0
#check specific error

function divver($enum,$denom)
{
    trap [System.DivideByZeroException]
    {
        Write-Host "Hey, chowderhead, you can't divide by Zero!"
        continue
    }

    trap{
        Write-Host "Oh NO ! An Error has occured !!"
        Write-Host $_.ErrorID
        Write-Host $_.Exception.Message
        break  #with break, or omitting it,error bubbles up to parent
    }

    Write-Host "Divver begin."
    $result=$enum/$denom
    Write-Host "Result : $result"
    Write-Host "Divver done."

}
cls
divver 33 0
#Two main ways to handle errors
#Option 1 - handle error Internally - See above function
#Option 2 - add trap logic in parent

#so Change continue to break
function divver($enum,$denom)
{
    trap [System.DivideByZeroException]
    {
        Write-Host "Hey, chowderhead, you can't divide by Zero!"
        break
    }

    trap{
        Write-Host "Oh NO ! An Error has occured !!"
        Write-Host $_.ErrorID
        Write-Host $_.Exception.Message
        break  #with break, or omitting it,error bubbles up to parent
    }

    Write-Host "Divver begin."
    $result=$enum/$denom
    Write-Host "Result : $result"
    Write-Host "Divver done."

}
#now call routine in script block  or other function
&{
        Clear-Host
        divver 33 0

        #Assume Child has handled error, keep going silently
        trap
        {
           continue
        }
}
#-------------------------------------------------------------------------------------------------
#------------Working with Files
#-------------------------------------------------------------------------------------------------
Clear-Host
Set-Location "\\AHOMEDIRPNAS\Homedirp\CCO148\ZGJW011"
Get-ChildItem "*.txt"
get-content "PShell.txt"
$a=Get-content  "PShell.txt"
clear-host
$a
#Looks are decptive , this is actually an array
$a[0]
$a[2]
$a.GetType()

Clear-Host
for($i=0;$i -le $a.Count;$i++)
{$a[$i]}

#To combine , we can use join , passing in the separator and the variable
$separator=[System.Environment]::NewLine  #could have done `r`n
$all=[string]::Join($separator,$a)
$all
$all.GetType()

#supports wildcards
$courses = Get-Content "?.txt"
$courses

$allcourses=[string]::Join($separator,$courses) 
$allcourses

#To write things to disk, use Set-Content
# just to prove it's not here
Get-ChildItem "All courses.txt"

Set-Content -Value $allcourses -Path "All courses.txt"
Get-Content "All courses.txt"

#Set-Content is destructive!!! If the file exists it's overwritten
Set-Content -Value "Powershell" -path "All Courses.txt"
get-Content "All Courses.txt"

#To append,use Add-Content
Add-Content -value $allcourses -Path "All Courses.txt" -verbose
Get-Content "All Courses.txt"
#clean up afterward
Remove-Item "All Courses.txt"

#CSV files
#Use it to save objects
Get-Process | Export-Csv "Processes.csv"
get-Content "*.csv"
$header="__NounName","Name","Handles","VM","WS","PM","NPM","Path","Company","CPU","FileVersion","ProductVersion","Description"
$processes=Import-CSV "Processes.csv" -Header $header -verbose
$processes

# XML Files
cls
# Create an XML Template
$courseTemplate=@"
<courses version="1.0">
  <course>
       <name></name>
       <level></level>
  </course>
</courses>
"@

$courseTemplate | Out-file "C:\Users\CCO148\scripts\Pluaralsight.xml" #-Verbose
#create a new xml varaible and load it from the file
$courseXml=New-Object xml
$courseXml.Load("C:\Users\CCO148\scripts\Pluaralsight.xml")
#Grab the template
$newCourse=(@($courseXml.courses.course)[0]).Clone()  
#Loop over the collection form the csv and add tehm to XML
$header="Course","Level" 
$coursecsv= Import-Csv "C:\Users\CCO148\scripts\All Courses.csv" -Header $header
For($i=0;$i -lt $coursecsv.Count;$i++)
{
#$coursecsv[$i].Course
   $newCourse = $newCourse.Clone() #copy the previous object ,or the first time copy the template
   $newCourse.Name=$coursecsv[$i].Course
   $newCourse.Level=$coursecsv[$i].Level
   $courseXml.Courses.AppendChild($newCourse) > $null 
}

#Remove the template since we now have data
$courseXml.Courses.Course |
          Where-Object {$_.Name -eq ""} |
          ForEach-Object{ [void]$courseXml.courses.RemoveChild($_)}
#Save to XML File
$courseXml.save("C:\Users\CCO148\scripts\Pluaralsight.xml")

#Open it up and show as a plain text file
$testXml=Get-Content "C:\Users\CCO148\scripts\Pluaralsight.xml"
$testXml

#Open it up and work with it as an XML file
[xml]$myCoursesXml=Get-Content "C:\Users\CCO148\scripts\Pluaralsight.xml"
foreach($course in $myCoursesXml.Courses.Course)
{
Write-Host "The course" $course.Name "is a level" $course.Level "Course."
}

