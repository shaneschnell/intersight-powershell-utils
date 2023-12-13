<#
Copyright (c) Cisco and/or its affiliates.
This software is licensed to you under the terms of the Cisco Sample
Code License, Version 1.0 (the "License"). You may obtain a copy of the
License at
               https://developer.cisco.com/docs/licenses
All use of the material herein must be in accordance with the terms of
the License. All rights not expressly granted by the License are
reserved. Unless required by applicable law or agreed to separately in
writing, software distributed under the License is distributed on an "AS
IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
or implied.
#>


#================================================================================================
# Configure API Signing Params
#================================================================================================
# . "$PSScriptRoot\..\..\api-config.ps1"


#================================================================================================
# Set Intersight Organization and Tags
#================================================================================================
try {
    $myOrg = Get-IntersightOrganizationOrganization -Name "default"
    $tags = @()
    $tags += Initialize-IntersightMoTag -Key "CreatedBy" -Value "PowerShell"

}
catch {
    # Check if the error message matches the specific error
    if ($_.Exception.Message -like "*Intersight environment is not configured*") {
        Write-Host "The Intersight environment is not configured." -ForegroundColor Red
        . "$PSScriptRoot\..\..\api-config.ps1"
        Write-Host "Please Run Script Again." -ForegroundColor Green
    }
    else {
        # Handle all other exceptions
        Write-Output "An unexpected error occurred: $_"
    }
    # Exit script with an error code
    exit 1

}


#================================================================================================
# Create Bios Policy
#================================================================================================
$policyName = 'M6-BIOS-Energy-Efficient'
$policyDescription = 'M6 Energy Efficient Bios Policy'

try {
    # Create the BIOS policy on Cisco Intersight:
    $policy = New-IntersightBiosPolicy `
        -Name $policyName `
        -Description $policyDescription `
        -Organization $myOrg `
        -Tags $tags

    # Modify BIOS settings as needed
    $policy.AdjacentCacheLinePrefetch = 'Disabled'
    $policy.EnergyEfficientTurbo = 'Enabled'
    $policy.HardwarePrefetch = 'Disabled'
    $policy.IpPrefetch = 'Disabled'
    $policy.PackageCstateLimit = 'C6NonRetention'
    $policy.ProcessorC1e = 'Enabled'
    $policy.ProcessorC6report = 'Enabled'
    $policy.StreamerPrefetch = 'Disabled'
    $policy.WorkLoadConfig = 'Balanced'

    $policy = $policy | Set-IntersightBiosPolicy
}
catch {
    # Do this if a terminating exception happens
    Write-Host "BIOS policy $policyName was not created."
    Write-Host $_.Exception.Message
    exit
}


#================================================================================================
# Verify that the BIOS policy was created successfully:
#================================================================================================
Write-Host "BIOS policy $policyName was successfully created."
Get-IntersightBiosPolicy -Name $policyName | Select-Object Name, Description