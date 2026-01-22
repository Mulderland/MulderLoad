function Nsis.MakeInstaller {
    param(
        [string]$nsiPath
    )

    # To create the installer directly with a given name, that would be :
    # $process = Start-Process "C:/Program Files (x86)/NSIS/makensis.exe" -ArgumentList @($nsiPath, """/XOutFile $releaseName.exe""") -PassThru -Wait

    $process = Start-Process "C:/Program Files (x86)/NSIS/makensis.exe" "$nsiPath" -PassThru -Wait
    if ($process.exitCode -ne 0) {
        throw "Error with makensis $nsiPath"
    }

    $exePath = $nsiPath.Replace('.nsi', '.exe')

    return $exePath
  }
