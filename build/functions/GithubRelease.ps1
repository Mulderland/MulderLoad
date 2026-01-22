function GithubRelease.GenerateName {
    param(
        [string]$nsiPath
    )

    $inputString = [system.Text.Encoding]::UTF8.GetBytes($nsiPath + $Env:RELEASE_NAME_SALT)
    $hasher = [System.Security.Cryptography.SHA1]::Create()
    $hash = [System.BitConverter]::ToString($hasher.ComputeHash($inputString)).Replace("-", "").ToLower()
    return $hash.Substring(0,7)
}

function GithubRelease.RenameInstaller {
    param(
        [string]$exePath,
        [string]$releaseName
    )

    $newName = "MulderLoad-" + $releaseName + ".exe"
    Rename-Item -Path $exePath -NewName $newName
    $exePath = $exePath.Replace([System.IO.Path]::GetFileName($exePath), $newName)

    return $exePath
  }

  function GithubRelease.UploadInstaller {
    param(
        [string]$exePath,
        [string]$releaseName
    )

    $process = Start-process "gh" "release view $releaseName" -PassThru -Wait
    if ($process.ExitCode -eq 0) {
        # The release already exists. Delete it to avoid weird history diff (tag vs main) on github.
        $process = Start-process "gh" "release delete $releaseName --cleanup-tag -y" -PassThru -Wait
        if ($process.ExitCode -ne 0) {
            throw "Error while deleting release $releaseName"
        }
    }

    $process = Start-process "gh" "release create $releaseName --notes setup" -PassThru -Wait
    if ($process.ExitCode -ne 0) {
        throw "Error while creating release $releaseName"
    }

    $process = Start-Process "gh" "release upload $releaseName $exePath --clobber" -PassThru -Wait
    if ($process.ExitCode -ne 0) {
        throw "Error while uploading release $releaseName assets"
    }
}
