$ErrorActionPreference = 'Stop'
Push-Location $PSScriptRoot

Write-Host " // Extract 7z"
Expand-Archive -Path "binaries\7z-v25.01.zip" -DestinationPath "7z" -Force

Write-Host " // Extract NSIS"
$process = Start-Process `
	-ArgumentList @('x', '-aoa', '-o.\nsis', 'binaries\nsis-3.11-setup.exe') `
	-FilePath ".\7z\7z.exe" `
	-NoNewWindow `
    -PassThru `
	-Wait
if ($process.ExitCode -ne 0) {
    exit $process.ExitCode
}
Remove-Item -Path 'nsis\$PLUGINSDIR' -Force -Recurse

Write-Host " // Extract Ns7z"
$process = Start-Process `
	-ArgumentList @('x', '-aoa', '-o.\nsis', 'binaries\Nsis7z_19.00.7z') `
	-FilePath ".\7z\7z.exe" `
	-NoNewWindow `
    -PassThru `
	-Wait
if ($process.ExitCode -ne 0) {
    exit $process.ExitCode
}

Write-Host " // Extract NSUnzU"
$process = Start-Process `
	-ArgumentList @('e', '-aoa', '-o".\nsis\Plugins\x86-unicode"', 'binaries\NSISunzU.zip', '"NSISunzU\Plugin unicode\nsisunz.dll"') `
	-FilePath ".\7z\7z.exe" `
	-NoNewWindow `
    -PassThru `
	-Wait
if ($process.ExitCode -ne 0) {
    exit $process.ExitCode
}

Write-Host " // Download & extract NSCurl"
$ProgressPreference = 'SilentlyContinue' # Disable progress bar
Invoke-WebRequest -Uri "https://github.com/negrutiu/nsis-nscurl/releases/download/v26.1.11.287/NScurl.zip" -OutFile "nsis\nscurl.zip"
Expand-Archive -Path "nsis\nscurl.zip" -DestinationPath "nsis" -Force
Remove-Item "nsis\nscurl.zip" -Force

Write-Host " // Install certificate"
if ($Env:CERTIFICATE_BASE64) {
    [Byte[]] $bytes = [System.Convert]::FromBase64String($Env:CERTIFICATE_BASE64)
    [IO.File]::WriteAllBytes("mulderload.pfx", $bytes)
    Write-Host "Certificate installed as mulderload.pfx"
} else {
    Write-Host "CERTIFICATE_BASE64 environment variable not set. Skipping."
}

Pop-Location
