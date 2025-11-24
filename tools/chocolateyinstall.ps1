$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$legacyRegistryKey = Get-MsiUninstallRegistryKey
if ($null -ne $legacyRegistryKey) {
  Write-Warning "A legacy MSI-based installation of en-croissant (v$($legacyRegistryKey.DisplayVersion)) was detected.
    To prevent possible issues with installation coexistence, this version will be uninstalled.
    While your files, databases, and engines should persist between installation types,
    you may need to readd your User Accounts and reconfigure your Settings."
  Uninstall-MsiPackage
}

$installerFileName = 'en-croissant_0.12.0_x64-setup.exe'
$filePath = Join-Path -Path $toolsDir -ChildPath $installerFileName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  file64         = $filePath
  softwareName   = 'en-croissant'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
