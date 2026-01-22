. $PSScriptRoot/functions/Cache.ps1
. $PSScriptRoot/functions/CodeSigning.ps1
. $PSScriptRoot/functions/GithubRelease.ps1
. $PSScriptRoot/functions/Nsis.ps1

if ($Env:ENABLE_CODE_SIGNING -eq "true") {
    CodeSigning.InstallCertificate
}

Get-ChildItem -Path '../games/abandonwares','../games/fangames','../games/patches' -Filter "*.nsi" | ForEach-Object {
    $nsiPath = $_.FullName | Resolve-Path -Relative

    $oldHash = Cache.ReadOldHash -nsiPath $nsiPath
    $newHash = Cache.GenerateNewHash -nsiPath $nsiPath

    if ($newHash -eq $oldHash) {
        Write-Output "$nsiPath is already up-to-date"
    } else {
        Write-Output "$nsiPath requires (re)make"

        # Nsis Installer
        $exePath = Nsis.MakeInstaller -nsiPath $nsiPath
        if ($Env:ENABLE_CODE_SIGNING -eq "true") {
            CodeSigning.SignExecutable -exePath $exePath
        }

        # Github Release
        if ($Env:ENABLE_GITHUB_RELEASE -eq "true") {
            $releaseName = GithubRelease.GenerateName -nsiPath $nsiPath
            $exePath = GithubRelease.RenameInstaller -exePath $exePath -releaseName $releaseName
            GithubRelease.UploadInstaller -exePath $exePath -releaseName $releaseName
        }

        # Cache
        Cache.SaveHash -nsiPath $nsiPath -hashValue $newHash
    }
  }
