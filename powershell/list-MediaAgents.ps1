# Filename: list-MediaAgents.ps1
# Purpose: List all the registered MediaAgents on the cuonfigured Commvault Backup & Recovery installation.
# Instructions:
#   1. Update the WebConsoleHostName with the fully-qualified hostname of your Commvault Backup & Recovery WebConsole host
#   2. Generate a Commvault AUTHCODE and enter into the API_token field
#   3. Execure with PowerShell

#
# GLOBAL variables - UPDATE THESE TO MATCH YOUR ENVIRONMENT
#
$WebConsoleHostName='localhost'
$authToken='INSERT_YOUR_COMMVAULT_REST_API_AUTH_TOKEN_HERE'
#
# DEBUG variables
#
$debug=0;
$timeoutInMinutes=1

#
# Main
#
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Accept", "application/json")
$headers.Add("Content-Type", "application/json")
if ($debug) {
	echo $headers 
}

#
# List all clients
#
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Accept", "application/json")
$headers.Add("Authtoken", "$authToken")

$response = Invoke-RestMethod 'http://localhost/webconsole/api/mediaAgent' -Method 'GET' -Headers $headers | ConvertTo-Json
echo $response
