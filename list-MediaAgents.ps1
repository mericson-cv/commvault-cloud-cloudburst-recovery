# Filename: cvctl.ps1
# Author: Mathew Ericson mericson@commvault.com
# Purpose: Command Line PowerShell utility that uses Commvault REST API instead of limited PowerShell Module
#

#
# GLOBAL variables
#
$API_token='3881030b1b2ec10c97d41e6fb414c2d479e338684b58cf8d24c614d930794bd2d7300480bb28c53740996774091c0c02e2a86e3b038051b592dceb4e249b8924d5dde547cd837a2f460dceccb83876a0566c5147eca12751d3cdc53d08afa65c5e1b5634340bb7445d1f834d86e6446d944d1aa01c0dd5e36ca15fb58b00c0acd9d1e10d9c3e81ca373b3a8afb84b8ac45da224ded4e5ccabcd9afbfa716af39349f760ec4eed529c02ddf27639fd243e13640749e73d8eb4b4567e41aae75742bac243d7e8a2386688af3f730c378964b607f0339d5cb4a47f0eae67df30105b'
$WebConsoleHostName='localhost'
$debug=0;
$timeoutInMinutes=1
$authToken='3881030b1b2ec10c97d41e6fb414c2d479e338684b58cf8d24c614d930794bd2d7300480bb28c53740996774091c0c02e2a86e3b038051b592dceb4e249b8924d5dde547cd837a2f460dceccb83876a0566c5147eca12751d3cdc53d08afa65c5e1b5634340bb7445d1f834d86e6446d944d1aa01c0dd5e36ca15fb58b00c0acd9d1e10d9c3e81ca373b3a8afb84b8ac45da224ded4e5ccabcd9afbfa716af39349f760ec4eed529c02ddf27639fd243e13640749e73d8eb4b4567e41aae75742bac243d7e8a2386688af3f730c378964b607f0339d5cb4a47f0eae67df30105b'

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Accept", "application/json")
$headers.Add("Content-Type", "application/json")
if ($debug) {
	echo $headers 
}

$body = "{`n  `"password`": `"QnVpbGRlciExMg==`",`n  `"username`": `"admin`",`n  `"timeout`" : $timeoutInMinutes`n}"
if ($debug) {
	echo "Body"
	echo $body
}


#
# List all clients
#
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Accept", "application/json")
$headers.Add("Authtoken", "$authToken")

$response = Invoke-RestMethod 'http://localhost/webconsole/api/mediaAgent' -Method 'GET' -Headers $headers | ConvertTo-Json
echo $response
#
# Get a list of MediaAgents
#
# $mediaagents | FT
#foreach ($MediaAgent in @mediaagents) {
#	echo "foo"
#	echo $($MediaAgent.entityInfo)
#}

	