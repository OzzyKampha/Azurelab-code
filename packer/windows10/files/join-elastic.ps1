
$root = 'https://10.0.2.20:5601/api/fleet/enrollment-api-keys'
$User = "elastic"
$Token = "elastic"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($User):$($Token)"))
$Header = @{
    Authorization = "Basic $base64AuthInfo"
}

$data = Invoke-RestMethod -Uri $root -Headers $Header

$api = $data.list.api_key[0]

$api

# Install agent
powershell -command c:\terraform\agent\elastic-agent-7.16.3-windows-x86_64\elastic-agent.exe install -f --insecure -v --url=https://10.0.2.20:8220 --enrollment-token=$api 