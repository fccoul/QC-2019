##TODO Review
cls
dir H:\ZGJW011 -Directory |
foreach -begin { $h=@{} ; $results=@()}
-process{
  $stat= dir $_.fullName -file -Recurse |
  Measure-Object -Property length -sum;
  $h.Path = $_.fullname; $h.Files=$stat.count ;
  $h.TotalSize=$stat.sum;
  $results+=[pscustomobject]$h
}
-end{
$results
}

#others
1..10
1..10 | foreach-object -process {$_ * 2}
1..10 | foreach {$_ * 2}
1..10 | foreach {$PSItem * 2} #same result
cls
<#
dir  H:\ZGJW011 -file -recurse |
Where {$_.length -ge 2  -AND $_.Extension -notmatch ".zip|.exe"} | foreach {
$file=Join-path -path $_.Directory -ChildPath "$($_.BaseName).zip"
Compress-Archive -path $_.FullName -Destinationpath $file -Compressionlevel Optimal -Force
}

dir  H:\ZGJW011\*.zip -Recurse 
#>

dir H:\ZGJW011 -Directory |
foreach -Begin {$h=@{} ; $results=@() } -Process {
$stat=dir $_.FullName -file -Recurse | Measure-Object -property length -sum
#$stat=dir $_.FullName -file | Measure-Object -property length -sum
$h.Path=$_.FullName
$h.Files=$stat.count
$h.TotalSize=$stat.sum
$results+=[pscustomobject]$h
} -end {
$results #| ls
}

get-service lanmanworkstation,winmgmt,vmicvss
get-service lanmanworkstation,winmgmt | foreach {$_.Pause()}
get-service lanmanworkstation,winmgmt
get-service lanmanworkstation,winmgmt | Resume-Service -PassThru
get-service lanmanworkstation,winmgmt

#Foreach enumarator
$numbers=1..10
foreach($n in $numbers)
{
    $max=get-random -Minimum 50 -Maximum 500
    $filename=join-path -path \\AHOMEDIRPNAS\Homedirp\CCO148\ZGJW011 -ChildPath "textFile-$n.txt"
    Set-Content -Value (1..$max) -Path $filename
    Get-Item $filename
}

#Pipe not allowed on foreaxch enumerator
#foreach($n in $numbers) {n+3} | sort -Descending
$r=foreach ($n in $numbers) {$n+3}
$r | sort -Descending
#Pipe  allowed on foreach - object
$numbers | foreach-object {$_+3}|sort -descending
 