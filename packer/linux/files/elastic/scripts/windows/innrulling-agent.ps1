

$root = 'https://10.0.2.10:5601/api/fleet/enrollment-api-keys'
$user = "elastic"
$pass= "elastic"
$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($user, $secpasswd)

$result = Invoke-RestMethod $root -Credential $credentia
#$result = Invoke-RestMethod $root  
$api = $result.api_key[-1]
.\elastic-agent.exe install -f --insecure -v --url=https://10.0.2.10:8220 --enrollment-token=$api 