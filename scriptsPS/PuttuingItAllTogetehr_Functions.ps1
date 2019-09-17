#PuttingItAllTogether_Functions.ps1
#functions for the Putting It All together demo

function Set-AppColors
{
<#
  .Synopsis
  Sets the application colors.

  .DESCRIPTION
  The function determines whether it's running in the ISE or a window,
  then sets the colors and window title appropiately.
#>
  if($psise -eq $null)
  {
      $Host.UI.RawUI.BackgroundColor="Black"
      $host.UI.RawUI.ForegroundColor="Green"
      $host.UI.RawUI.WindowTitle="Putting it all together"
  }
  else
  {
      $psise.Options.OutputPaneBackgroundColor="Black"
      $psise.Options.OutputPaneTextBackgroundColor="Black"
      $psise.Options.OutputPaneForegroundColor="#FF00E000"
      $host.ui.RawUI.WindowTitle="Putting it all together ISE !"

  }
  }
  function Get-WindowWidth
  {
  <#
     .SYNOPSIS
     Returns the width of the current window.

     .DESCRIPTION
     If running in the ISE, the max window size will be null.if so,
     return aq default of 80. Otherwise return the true window width
  #>

  if($Host.UI.RawUI.MaxWindowSize -eq $NULL)
  {
     $windowwidth=80
  }
  else
  {
     $windowwidth=$host.UI.RawUI.MaxWindowSize.Width
  }
  return $windowwidth

  }

  function Display-AppHeader($title)
  {
  <#
      .SYNOPSIS
      Displays a title surrounded by *'S

      .DESCRIPTION
      Displays the passed in title, centered on the screen and surrounded by a nice frame

      .PARAMETER title
      the Title you want displayed

      .NOTES
      Requires the Get-WindowWidth function
  #>

  #make sure a title was passed in and has a minimum length
  if($title.Length -lt 2) {$title=$title+" "}

  $ww=(Get-WindowWidth) - 4 #2 for the *'s and 2 for a gap
  if(($title.Length % 2) -ne 0)
  {$title=$title+ " "}
  
  $pad=" "*(($ww-$title.Length) / 2)
  
  "*"+"-"*$ww+"*"

  Write-Host -NoNewline "*"
  Write-Host -NoNewline $pad
  Write-Host -NoNewline -ForegroundColor "White" $title
  Write-Host -NoNewline $pad
  Write-Host "*"

  "*"+"-"*$ww+"*"
}

function Write-TxtFile($Path,$Contents,[switch]$verbose,[switch]$debug)
{
  <#
     .SYNOPSIS
     Writes a string to a text file

     .DESCRIPTION
     takes the value in the Contenets parameter and writes it to the text file
     specified in the path parameter.
     It will see if a BAK file exists,and if so remove it.
     It Will the copy the current file, if it exists, to a BAK file

     .PARAMETER Path
     The file name to write to. If the file does not end in .txt,it will automaticallt be added.

     .PARAMETER Contents
     The contyents to write to the file
  #>
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

  [string]$FileName=$Path

  Write-Debug "FileName is $FileName"
  Write-Debug "Contents are $Contents"

  #Validate that the TXT extension is present
  if(!$FileName.ToLower().EndsWith(".txt"))
  {
     $fileName=($FileName+".txt")
  }

  Write-Debug "FileName after txt check is $FileName"

  # if There is a .bak file out there delete it
  if(test-Path ($FileName+".bak"))
  {
    Write-Debug "Removing BAK File"
    Remove-item ($FileName+".bak")
  }

  #If the file already exists, copy it to a .bak
  if(Test-Path $FileName)
  {
     Write-Debug "Copying file to BAK"
     Rename-Item -Path $FileName -NewName ($FileName+".bak")
  }

  #Save the file
  Write-Debug "Saving ""$Contents"" to $FileName"
  Set-Content -Value $Contents -Path $FileName


}