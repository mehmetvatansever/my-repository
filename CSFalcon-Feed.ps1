####__Configure CrowdStrike Indicator Feed on Powershell Script__####
#
Invoke-WebRequest http://ip-or-domain-url/data.txt -OutFile C:\Windows\Temp\misp-ipv4.csv
#
Request-FalconToken -ClientId !entry_clientid! -ClientSecret !entry_clientsecret!
#
$dateFormat='yyyy-MM-ddTHH:mm:00Z'
#
$90DaysAgo = (Get-Date).AddDays(+90)
#
$Date = Get-Date -Date $90DaysAgo -Format $dateFormat
#
$misp = import-csv C:\Windows\Temp\misp-ipv4.csv -Header IP
#
foreach($misps in $misp){New-FalconIoc -Source "1" -Action "Detect" -Expiration $Date -Description "MISP FEED IP LIST" -Type ipv4 -Value $misps.ip -Platform "Windows" -Severity "Critical" -AppliedGlobally $true}
#
