# Filename: retire-MediaAgents.ps1
# Purpose: List all the registered MediaAgents on the cuonfigured Commvault Backup & Recovery installation.
# Instructions:
#   1. Update the WebConsoleHostName with the fully-qualified hostname of your Commvault Backup & Recovery WebConsole host
#   2. Generate a Commvault AUTHCODE and enter into the API_token field
#   3. Execure with PowerShell
#

#
# GLOBAL variables
#
$authToken='INSERT_YOUR_COMMVAULT_AUTHTOKEN'
$webConsoleHost="localhost"

if($args.Count -eq 0) {
    echo "Syntax: retire-MediaAgents.ps1 <MediaAgent-ClientID> <MediaAgent-ClientID> <MediaAgent-ClientID>"
    echo "Please supply at least one MediaAgent client ID to retire and delete."
    echo ""
    echo ""
    exit 1
}

foreach ($argument in $args) {
	echo "Deleting Media Agent ClientID: $argument"
	#
	# GLOBAL variables
	#

	$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$headers.Add("Accept", "application/json")
	$headers.Add("Authtoken", "$authToken")

	Invoke-RestMethod http://$($webConsoleHost)/webconsole/api/Client/$($argument)/Retire -Method 'DELETE'-Headers $headers | ConvertTo-Json
}

exit 0
