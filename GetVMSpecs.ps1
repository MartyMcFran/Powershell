$ComputerName = "YKGYNS1"
$Username = "a_kferdous@montefiore.org"
$Password = ConvertTo-SecureString "gx7RGB%^ML" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($Username, $Password)



$OperatingSystem = Get-WmiObject Win32_OperatingSystem -ComputerName $ComputerName -Credential $Credential
$Processors = Get-WmiObject Win32_Processor -ComputerName $ComputerName -Credential $Credential
$Memory = Get-WmiObject Win32_ComputerSystem -ComputerName $ComputerName -Credential $Credential
$HardDisk = Get-WmiObject Win32_LogicalDisk -ComputerName $ComputerName -Filter "DriveType = 3" -Credential $Credential



$NumberOfCores = ($Processors | Measure-Object -Property NumberOfCores -Sum).Sum

 

$NetworkAdapterConfig = Get-WmiObject Win32_NetworkAdapterConfiguration -ComputerName $ComputerName -Filter "IPEnabled = 'True'" -Credential $Credential

 

$MemoryGB = [Math]::Ceiling($Memory.TotalPhysicalMemory / 1GB)

 

write-Host ""
foreach ($Adapter in $NetworkAdapterConfig) {
    Write-Host "Adapter Name: " $Adapter.Description
    Write-Host "IP Address: " $Adapter.IPAddress
    Write-Host "Subnet Mask: " $Adapter.IPSubnet
    Write-Host "Default Gateway: " $Adapter.DefaultIPGateway
    Write-Host "DNS Servers: " $Adapter.DNSServerSearchOrder
}

 

write-Host ""
Write-Host "Operating System: " $OperatingSystem.Caption
Write-Host "Memory: " $MemoryGB "GB"
Write-Host "CPU Cores: " $NumberOfCores
write-Host ""

 

foreach ($Disk in $HardDisk) {
    $TotalSpaceGB = [Math]::Ceiling($Disk.Size / 1GB)
    $FreeSpaceGB = [Math]::Ceiling($Disk.FreeSpace / 1GB)

 

    Write-Host "Drive: " $Disk.DeviceID
    Write-Host "Total Space: " $TotalSpaceGB "GB"
    Write-Host "Free Space: " $FreeSpaceGB "GB"
}