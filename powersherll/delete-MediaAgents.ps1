# Filename: delete-MA.ps1
# Author: Mathew Ericson mericson@commvault.com
# Purpose: Command Line PowerShell utility that uses Commvault REST API instead of limited PowerShell Module
#
if($args.Count -eq 0) {
    echo "Syntax: delete-MA.ps1 <ClientID> <ClientID> <ClientID>"
    echo "Please supply at least one client ID to delete and retire".
    exit 1
}

foreach ($argument in $args) {
	echo "Deleting ClientID: $argument"
	#
	# GLOBAL variables
	#
	$authToken='3881030b1b2ec10c97d41e6fb414c2d479e338684b58cf8d24c614d930794bd2d7300480bb28c53740996774091c0c02e2a86e3b038051b592dceb4e249b8924d5dde547cd837a2f460dceccb83876a0566c5147eca12751d3cdc53d08afa65c5e1b5634340bb7445d1f834d86e6446d944d1aa01c0dd5e36ca15fb58b00c0acd9d1e10d9c3e81ca373b3a8afb84b8ac45da224ded4e5ccabcd9afbfa716af39349f760ec4eed529c02ddf27639fd243e13640749e73d8eb4b4567e41aae75742bac243d7e8a2386688af3f730c378964b607f0339d5cb4a47f0eae67df30105b'

	$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$headers.Add("Accept", "application/json")
	$headers.Add("Authtoken", "$authToken")

	echo "Deleting MediaAgent"
	Invoke-RestMethod http://localhost/webconsole/api/mediaAgent/$($argument)?reviewedReport=true -Method 'DELETE' -Headers $headers | ConvertTo-Json
	echo "Deleting Client"
	Invoke-RestMethod http://localhost/webconsole/api/Client/$($argument)?forceDelete=true -Method 'DELETE' -Headers $headers | ConvertTo-Json
}

exit 0
	
