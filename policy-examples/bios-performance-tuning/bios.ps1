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

[cmdletbinding()]
param(
    [parameter(Mandatory = $true)][ValidateSet("M6","M7","Both")][string]$platform
)


#================================================================================================
# Configure API Signing Params
#================================================================================================
. "$PSScriptRoot\..\..\api-config.ps1"


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
# M7 BIOS Policies
#================================================================================================
if ($platform -eq "M7" -or $platform -eq "Both") {
    try {
        New-IntersightBiosPolicy `
            -Name 'M7-BIOS-CPU-Intensive' `
            -Description 'M7 CPU Intensive Bios Policy' `
            -Organization $myOrg `
            -LlcAlloc 'Disabled' `
            -LlcPrefetch 'Disabled' `
            -PatrolScrub 'Disabled' `
            -ProcessorC6report 'Enabled' `
            -Snc 'SNC4' `
            -UpiLinkEnablement '2' `
            -UpiPowerManagement 'Enabled' `
            -XptPrefetch 'Enabled' `
            -Tags $tags
            # Missing: ADDDC sparing
            # Missing: UPI prefetch
    }
    catch {
        # Handle all exceptions
        Write-Output "An error occurred: $_"
        # Exit the script with an error code
        exit 1
    }

    try {
        New-IntersightBiosPolicy `
            -Name 'M7-BIOS-Energy-Efficient' `
            -Description 'M7 Energy Efficient Bios Policy' `
            -Organization $myOrg `
            -EnergyEfficientTurbo 'Enabled' `
            -PackageCstateLimit 'C6NonRetention' `
            -ProcessorC1e 'Enabled' `
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

    try {
        New-IntersightBiosPolicy `
            -Name 'M7-BIOS-Low-Latency' `
            -Description 'M7 Low Latency Bios Policy' `
            -Organization $myOrg `
            -IntelHyperThreadingTech 'Disabled' `
            -IntelTurboBoostTech 'Disabled' `
            -IntelVirtualizationTechnology 'Disabled' `
            -IntelVtForDirectedIo 'Disabled' `
            -WorkLoadConfig 'Balanced' `
            -Tags $tags
    }
    catch {
        # Handle all exceptions
        Write-Output "An error occurred: $_"
        # Exit the script with an error code
        exit 1
    }

    try {
        New-IntersightBiosPolicy `
            -Name 'M7-BIOS-RelationalDB' `
            -Description 'M7 Relational database systems Bios Policy' `
            -Organization $myOrg `
            -PatrolScrub 'Disabled' `
            -LlcAlloc 'Disabled' `
            -LlcPrefetch 'Disabled' `
            -Snc 'Auto' `
            -XptPrefetch 'Enabled' `
            -Tags $tags
    }
    catch {
        # Handle all exceptions
        Write-Output "An error occurred: $_"
        # Exit the script with an error code
        exit 1
    }

    try {
        New-IntersightBiosPolicy `
            -Name 'M7-BIOS-Virtualization' `
            -Description 'M7 Virtualization Bios Policy' `
            -Organization $myOrg `
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

    try {
        New-IntersightBiosPolicy `
            -Name 'M7-BIOS-Data-Analytics' `
            -Description 'M7 Data Analytics Bios Policy' `
            -Organization $myOrg `
            -IntelVirtualizationTechnology 'Disabled' `
            -ProcessorC6report 'Enabled' `
            -Tags $tags
    }
    catch {
        # Handle all exceptions
        Write-Output "An error occurred: $_"
        # Exit the script with an error code
        exit 1
    }

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

    try {
        New-IntersightBiosPolicy `
            -Name 'M7-BIOS-HPC' `
            -Description 'M7 High Performance Computing Bios Policy' `
            -Organization $myOrg `
            -IntelVirtualizationTechnology 'Disabled' `
            -LlcAlloc 'Disabled' `
            -LlcPrefetch 'Disabled' `
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
}


#================================================================================================
# M6 BIOS Policies
#================================================================================================
if ($platform -eq "M6" -or $platform -eq "Both") {
    New-IntersightBiosPolicy `
        -Name 'M6-BIOS-CPU-Intensive' `
        -Description 'M6 CPU Intensive Bios Policy' `
        -Organization $myOrg `
        -AdjacentCacheLinePrefetch 'Disabled' `
        -CpuPerfEnhancement 'Auto' `
        -ImcInterleave '_1WayInterleave' `
        -LlcAlloc 'Disabled' `
        -LlcPrefetch 'Disabled' `
        -MemoryRefreshRate '_1xRefresh' `
        -PatrolScrub 'Disabled' `
        -ProcessorC1e 'Enabled' `
        -ProcessorC6report 'Enabled' `
        -SelectMemoryRasConfiguration 'MaximumPerformance' `
        -Snc 'Enabled' `
        -StreamerPrefetch 'Disabled' `
        -UfsDisable 'Disabled' `
        -UpiLinkEnablement '1' `
        -UpiPowerManagement 'Enabled' `
        -WorkLoadConfig 'Balanced' `
        -XptPrefetch 'Enabled' `
        -Tags $tags
        # Missing: UPI prefetch

    New-IntersightBiosPolicy `
        -Name 'M6-BIOS-IO-Intensive' `
        -Description 'M6 IO Intensive Bios Policy' `
        -Organization $myOrg `
        -AdjacentCacheLinePrefetch 'Disabled' `
        -HardwarePrefetch 'Disabled' `
        -LlcPrefetch 'Disabled' `
        -StreamerPrefetch 'Disabled' `
        -Tags $tags

    New-IntersightBiosPolicy `
        -Name 'M6-BIOS-Energy-Efficient' `
        -Description 'M6 Energy Efficient Bios Policy' `
        -Organization $myOrg `
        -AdjacentCacheLinePrefetch 'Disabled' `
        -EnergyEfficientTurbo 'Enabled' `
        -HardwarePrefetch 'Disabled' `
        -IpPrefetch 'Disabled' `
        -PackageCstateLimit 'C6NonRetention' `
        -ProcessorC1e 'Enabled' `
        -ProcessorC6report 'Enabled' `
        -StreamerPrefetch 'Disabled' `
        -WorkLoadConfig 'Balanced' `
        -Tags $tags

    New-IntersightBiosPolicy `
        -Name 'M6-BIOS-Low-Latency' `
        -Description 'M6 Low Latency Bios Policy' `
        -Organization $myOrg `
        -CpuPerformance 'Enterprise' `
        -EnergyEfficientTurbo 'Enabled' `
        -IntelTurboBoostTech 'Disabled' `
        -IntelVirtualizationTechnology 'Disabled' `
        -IntelVtForDirectedIo 'Disabled' `
        -MemoryRefreshRate '_1xRefresh' `
        -WorkLoadConfig 'Balanced' `
        -Tags $tags

    New-IntersightBiosPolicy `
        -Name 'M6-BIOS-RelationalDB' `
        -Description 'M6 Relational database systems Bios Policy' `
        -Organization $myOrg `
        -CpuPerfEnhancement 'Auto' `
        -ImcInterleave '_1WayInterleave' `
        -LlcAlloc 'Disabled' `
        -LlcPrefetch 'Disabled' `
        -MemoryRefreshRate '_1xRefresh' `
        -PatrolScrub 'Disabled' `
        -ProcessorC6report 'Enabled' `
        -Snc 'Enabled' `
        -UpiPowerManagement 'Enabled' `
        -XptPrefetch 'Enabled' `
        -Tags $tags

    New-IntersightBiosPolicy `
        -Name 'M6-BIOS-Virtualization' `
        -Description 'M6 Virtualization Bios Policy' `
        -Organization $myOrg `
        -CpuPerfEnhancement 'Auto' `
        -EnergyEfficientTurbo 'Enabled' `
        -ProcessorC1e 'Enabled' `
        -ProcessorC6report 'Enabled' `
        -Tags $tags

    New-IntersightBiosPolicy `
        -Name 'M6-BIOS-Data-Analytics' `
        -Description 'M6 Data Analytics Bios Policy' `
        -Organization $myOrg `
        -CpuPerfEnhancement 'Auto' `
        -EnergyEfficientTurbo 'Enabled' `
        -IntelVtForDirectedIo 'Disabled' `
        -ProcessorC1e 'Enabled' `
        -ProcessorC6report 'Enabled' `
        -WorkLoadConfig 'Balanced' `
        -Tags $tags

    New-IntersightBiosPolicy `
        -Name 'M6-BIOS-Analytical-Database-Systems' `
        -Description 'M6 Analytical Database Systems Bios Policy' `
        -Organization $myOrg `
        -CpuPerfEnhancement 'Auto' `
        -EnergyEfficientTurbo 'Enabled' `
        -IntelVirtualizationTechnology 'Disabled' `
        -IntelVtForDirectedIo 'Disabled' `
        -MemoryRefreshRate '_1xRefresh' `
        -PatrolScrub 'Disabled' `
        -ProcessorC6report 'Enabled' `
        -WorkLoadConfig 'Balanced' `
        -Tags $tags

    New-IntersightBiosPolicy `
        -Name 'M6-BIOS-HPC' `
        -Description 'M6 High Performance Computing Bios Policy' `
        -Organization $myOrg `
        -CpuPerfEnhancement 'Auto' `
        -ImcInterleave '_1WayInterleave' `
        -IntelVirtualizationTechnology 'Disabled' `
        -IntelVtForDirectedIo 'Disabled' `
        -LlcAlloc 'Disabled' `
        -LlcPrefetch 'Disabled' `
        -MemoryRefreshRate '_1xRefresh' `
        -PatrolScrub 'Disabled' `
        -Snc 'Enabled' `
        -UpiPowerManagement 'Enabled' `
        -WorkLoadConfig 'Balanced' `
        -XptPrefetch 'Enabled' `
        -Tags $tags
}