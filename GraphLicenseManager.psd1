#
# Module manifest for module 'GraphLicenseManager'
#
# Generated by: timmcmic
#
# Generated on: 10/20/2024
#

@{

# Script module or binary module file associated with this manifest.
 RootModule = '.\GraphLicenseManager.psm1'

# Version number of this module.
ModuleVersion = '1.0.10'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = 'bdc7ed32-de5b-4bde-a76c-52761dcd0a3b'

# Author of this module
Author = 'timmcmic'

# Company or vendor of this module
CompanyName = 'Microsoft CSS'

# Copyright statement for this module
Copyright = '(c) timmcmic. All rights reserved.'

# Description of the functionality provided by this module
Description = 'This powershell module will assist customers in managing and setting group based licensing.'

# Minimum version of the PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(
    @{ModuleName = 'Microsoft.Graph.Authentication' ; ModuleVersion = '2.24.0'}
    @{ModuleName = 'Microsoft.Graph.Users' ; ModuleVersion = '2.24.0'}
    @{ModuleName = 'Microsoft.Graph.Groups' ; ModuleVersion = '2.24.0'}
    @{ModuleName = 'Microsoft.Graph.Identity.DirectoryManagement' ; ModuleVersion = '2.24.0'}
    @{ModuleName = 'PowerShellGet'; ModuleVersion = '2.2.5'}
    @{ModuleName = 'TelemetryHelper'; ModuleVersion = '2.1.2'}
)

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('GetLicenseData.ps1','DisplayGroupInfo.ps1','send-TelemetryEvent.ps1','get-universalDateTime.ps1','get-elapsedTime.ps1','test-powerShellModule.ps1','start-telemetryconfiguration.ps1','EstablishGraphConnection.ps1','ManageGroupLicense.ps1','new-logfile.ps1','Out-LogFile.ps1','Out-XMLFile.ps1')

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @('start-GraphLicenseManager')

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        # ProjectUri = ''

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

