Import-Module au

$currentPath = (Split-Path $MyInvocation.MyCommand.Definition)
. $currentPath\helpers.ps1

$toolsPath = Join-Path -Path $currentPath -ChildPath 'tools'

$owner = 'franciscoBSalgueiro'
$repository = 'en-croissant'

function global:au_BeforeUpdate ($Package) {
    Get-RemoteFiles -Purge -NoSuffix -Algorithm sha256

    Copy-Item -Path "$toolsPath\VERIFICATION.txt.template" -Destination "$toolsPath\VERIFICATION.txt" -Force

    Set-DescriptionFromReadme -Package $Package -ReadmePath '.\DESCRIPTION.md'
}

function global:au_AfterUpdate ($Package) {
    $licenseUri = "https://raw.githubusercontent.com/$($owner)/$($repository)/v$($Latest.SoftwareVersion)/LICENSE"
    $licenseContents = Invoke-WebRequest -Uri $licenseUri -UseBasicParsing

    Set-Content -Path 'tools\LICENSE.txt' -Value "From: $licenseUri`r`n`r`n$licenseContents" -NoNewline

    #Archive the current source code to prepare for possible redistribution requests, as required by GPLv3
    Get-SourceCode -Version $($Latest.SoftwareVersion)
}

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            '(<packageSourceUrl>)[^<]*(</packageSourceUrl>)' = "`$1https://github.com/brogers5/chocolatey-package-$($Latest.PackageName)/tree/v$($Latest.Version)`$2"
            '(<licenseUrl>)[^<]*(</licenseUrl>)'             = "`$1https://github.com/$($owner)/$($repository)/blob/v$($Latest.SoftwareVersion)/LICENSE`$2"
            '(<projectSourceUrl>)[^<]*(</projectSourceUrl>)' = "`$1https://github.com/$($owner)/$($repository)/tree/v$($Latest.SoftwareVersion)`$2"
            '(<releaseNotes>)[^<]*(</releaseNotes>)'         = "`$1https://github.com/$($owner)/$($repository)/releases/tag/v$($Latest.SoftwareVersion)`$2"
            '(<copyright>)[^<]*(</copyright>)'               = "`$1Copyleft (ɔ) 2023-$((Get-Date).Year) Francisco Salgueiro`$2"
        }
        'tools\VERIFICATION.txt'        = @{
            '%checksumValue%'  = "$($Latest.Checksum64)"
            '%checksumType%'   = "$($Latest.ChecksumType64.ToUpper())"
            '%tagReleaseUrl%'  = "https://github.com/$($owner)/$($repository)/releases/tag/v$($Latest.SoftwareVersion)"
            '%binaryUrl%'      = "$($Latest.Url64)"
            '%binaryFileName%' = "$($Latest.FileName64)"
        }
        'tools\chocolateyinstall.ps1'   = @{
            "(^[$]installerFileName\s*=\s*)('.*')" = "`$1'$($Latest.FileName64)'"
        }
    }
}

function global:au_GetLatest {
    $version = Get-LatestStableVersion

    return @{
        Url64           = Get-SoftwareUri
        Version         = $version #This may change if building a package fix version
        SoftwareVersion = $version
    }
}

Update-Package -ChecksumFor None -NoReadme
