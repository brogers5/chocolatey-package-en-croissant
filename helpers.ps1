Import-Module PowerShellForGitHub

$installerFileNameRegex = 'en-croissant_([\d\.]+)_x64-setup\.exe$'
$owner = 'franciscoBSalgueiro'
$repository = 'en-croissant'

function Get-GitHubReleaseObject([version] $Version) {
    if ($null -eq $Version) {
        # Default to latest stable version
        $release = (Get-GitHubRelease -OwnerName $owner -RepositoryName $repository -Latest)[0]
    }
    else {
        $release = Get-GitHubRelease -OwnerName $owner -RepositoryName $repository -Tag "v$($Version.ToString())"
    }

    return $release
}

function Get-LatestStableVersion {
    $latestRelease = (Get-GitHubRelease -OwnerName $owner -RepositoryName $repository -Latest)[0]

    return [Version] $latestRelease.tag_name.Substring(1)
}

function Get-SourceCode([version] $Version) {
    $release = Get-GitHubReleaseObject -Version $Version
    $userAgent = 'Update checker of Chocolatey Community Package ''en-croissant'''
    Invoke-WebRequest -Uri $release.zipball_url -UserAgent $userAgent -OutFile ".\en-croissant-$Version.zip" -UseBasicParsing
}

function Get-SoftwareUri($Version) {
    $release = Get-GitHubReleaseObject -Version $Version
    $releaseAssets = Get-GitHubReleaseAsset -OwnerName $owner -RepositoryName $repository -Release $release.ID

    $windowsInstallerAsset = $null
    foreach ($asset in $releaseAssets) {
        if ($asset.name -match $installerFileNameRegex) {
            $windowsInstallerAsset = $asset
            break
        }
        else {
            continue
        }
    }

    if ($null -eq $windowsInstallerAsset) {
        throw 'Cannot find published Windows installer asset!'
    }

    return $windowsInstallerAsset.browser_download_url
}