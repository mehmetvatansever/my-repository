####__Configure CrowdStrike Indicator(IP, Domain, Hash) Feed on Powershell Script__####
#
####_Created by Mehmet Vatansever_####
#
Invoke-WebRequest http://ipv4.com/data.txt -OutFile C:\Windows\Temp\misp-ipv4.csv
#
Invoke-WebRequest http://dns.com/domain.txt -OutFile C:\Windows\Temp\misp-dns.csv
#
Invoke-WebRequest http://hash.com/hash.txt -OutFile C:\Windows\Temp\misp-hash.csv
#
#
#
Request-FalconToken -ClientId !entry_clientid! -ClientSecret !entry_clientsecret!
#
$dateFormat='yyyy-MM-ddTHH:mm:00Z'
#
$90DaysAgo = (Get-Date).AddDays(+90)
#
$Date = Get-Date -Date $90DaysAgo -Format $dateFormat
#
#
#
$mispipv4 = import-csv C:\Windows\Temp\misp-ipv4.csv -Header IP
#
$mispdns = import-csv C:\Windows\Temp\misp-dns.csv -Header DNS
#
$misphash = import-csv C:\Windows\Temp\misp-hash.csv -Header HASH
#
#
#
foreach($mispipv4s in $mispipv4){New-FalconIoc -Source "1" -Action "Detect" -Expiration $Date -Description "MISP FEED IP LIST" -Type ipv4 -Value $mispipv4s.ip -Platform Windows, Linux, Mac -Severity "Critical" -AppliedGlobally $true}
#
foreach($mispdnss in $mispdns){New-FalconIoc -Source "2" -Action "Detect" -Expiration $Date -Description "MISP FEED DOMAIN LIST" -Type domain -Value $mispdnss.dns -Platform Windows, Linux, Mac -Severity "Critical" -AppliedGlobally $true}
#
foreach($misphashs in $misphash){New-FalconIoc -Source "3" -Action "Prevent" -Description "MISP FEED MD5 LIST" -Type md5 -Value $misphashs.hash -Platform Windows, Linux, Mac -Severity "Critical" -AppliedGlobally $true}
#
#
####_End_####
