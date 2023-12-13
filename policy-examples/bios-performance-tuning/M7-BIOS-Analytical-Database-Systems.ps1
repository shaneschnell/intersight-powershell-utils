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
. "$PSScriptRoot\..\api-config.ps1"


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
        . "$PSScriptRoot\..\api-config.ps1"
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
# Create M7 Analytical Database Systems Bios Policy
#================================================================================================
try {
    New-IntersightBiosPolicy `
        -Name 'M7-BIOS-Analytical-Database-Systems' `
        -Description 'M7 Analytical Database Systems Bios Policy' `
        -Organization $myOrg `
        -IntelVirtualizationTechnology 'Disabled' `
        -ProcessorC6report 'Enabled' `
        -WorkLoadConfig 'Balanced' `
        -Tags $tags
}
catch {
    # Handle all exceptions
    Write-Output "An error occurred: $_"
    # Exit the script with an error code
    exit 1
}