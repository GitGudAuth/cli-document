# Check how many CPU cores
$cpuCores = (Get-WmiObject -Class Win32_Processor | Measure-Object -Property NumberOfCores -Sum).Sum
# Check how many RAM
$ramGB = [math]::Round((Get-WmiObject -Class Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB, 0)
# Check disk space
$diskTotalGB = [math]::Round((Get-PSDrive -Name C).Used / 1GB + (Get-PSDrive -Name C).Free / 1GB, 0)
"Disk: $diskTotalGB GB"
"CPU: $cpuCores Cores"
"RAM: $ramGB GB"
