# <img src="https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-en-croissant@997009f54daa82d14c05998c3f979e1418641b45/en-croissant.png" width="48" height="48"/> Chocolatey Package: [En Croissant - The Ultimate Chess Toolkit](https://community.chocolatey.org/packages/en-croissant)

[![Latest package version shield](https://img.shields.io/chocolatey/v/en-croissant.svg)](https://community.chocolatey.org/packages/en-croissant)
[![Total package download count shield](https://img.shields.io/chocolatey/dt/en-croissant.svg)](https://community.chocolatey.org/packages/en-croissant)

## Install

[Install Chocolatey](https://chocolatey.org/install), and run the following command to install the latest approved stable version from the Chocolatey Community Repository:

```shell
choco install en-croissant --source="'https://community.chocolatey.org/api/v2'"
```

Alternatively, the packages as published on the Chocolatey Community Repository will also be mirrored on this repository's [Releases page](https://github.com/brogers5/chocolatey-package-en-croissant/releases). The `nupkg` can be installed from the current directory (with dependencies sourced from the Community Repository) as follows:

```shell
choco install en-croissant --source="'.;https://community.chocolatey.org/api/v2/'"
```

## Build

[Install Chocolatey](https://chocolatey.org/install), the [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au), and the [PowerShellForGitHub PowerShell Module](https://github.com/microsoft/PowerShellForGitHub), then clone this repository.

Once cloned, simply run `build.ps1`. The MSI is intentionally untracked to avoid bloating the repository, so the script will download the En Croissant installer MSI from the official distribution point, then packs everything together.

A successful build will create `en-croissant.x.y.z.nupkg`, where `x.y.z` should be the Nuspec's normalized `version` value at build time.

>[!Note]
>Chocolatey package builds are non-deterministic. Consequently, an independently built package's checksum will not match that of the officially published package.

## Update

This package should be automatically updated by the [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au), with update queries implemented by the [PowerShellForGitHub PowerShell Module](https://github.com/microsoft/PowerShellForGitHub). If it is outdated by more than a few days, please [open an issue](https://github.com/brogers5/chocolatey-package-en-croissant/issues).

AU expects the parent directory that contains this repository to share a name with the Nuspec (`en-croissant`). Your local repository should therefore be cloned accordingly:

```shell
git clone git@github.com:brogers5/chocolatey-package-en-croissant.git en-croissant
```

Alternatively, a junction point can be created that points to the local repository (preferably within a repository adopting the [AU packages template](https://github.com/majkinetor/au-packages-template)):

```shell
mklink /J en-croissant ..\chocolatey-package-en-croissant
```

Once created, simply run `update.ps1` from within the created directory/junction point. Assuming all goes well, all relevant files should change to reflect the latest version available. This will also build a new package version using the modified files.

Before submitting a pull request, please [test the package](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier#steps-for-each-package) using the latest [Chocolatey Testing Environment](https://github.com/chocolatey-community/chocolatey-test-environment) first.
