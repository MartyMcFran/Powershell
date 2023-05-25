$datacenter = Read-host "data center name: " tacho
$department = Read-Host "Enter department 3 letter code: "
$virtorphy = Read-Host "v for virtual or p for physical? "
$winorlinux = Read-Host "w for windows or L for linux? "
$evinronment = Read-Host "P for prod, T for test, D for dev? "

$vmnameprefix = $datacenter+$department+$virtorphy+$winorlinux+$evinronment

#$serverOU = "OU=_Servers,DC=montefiore,DC=org"

$servers = Get-ADComputer -Filter {ObjectClass -eq "computer"} | Where-Object Name -Match "$vmnameprefix*"

$servers = $servers | Select-Object Name

$servers = $servers | Sort-Object Name

$lastServer = $servers[-1]

$lastServerName = $lastServer.Name

$vmnameNumber = $lastServerName.Split("$vmnameprefix")[-1]

$incrementalNumber = [int] $vmnameNumber

$nextIncrementalNumber = $incrementalNumber+1

$newServerName = $lastServerName.Replace($incrementalnumnber, $nextIncrementalNumber)

Write-Host $newServerName
