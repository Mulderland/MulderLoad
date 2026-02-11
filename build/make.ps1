param(
    [Parameter(Mandatory)]
    [String]$nsiPath,
    [switch]$sign
)

$ErrorActionPreference = 'Stop'
Push-Location $PSScriptRoot

function GenerateExeName($nsiPath) {
    # Normalize to forward slashes for easy splitting
    $normalizedPath = (($nsiPath -replace '\\', '/') -replace '/+', '/')

    # Split on games/ and require exactly 2 parts
    $parts = $normalizedPath -split '(?:^|/)games/', 2
    if ($parts.Count -ne 2) {
        Write-Host "Error: expected path containing 'games/' (e.g. ../games/<game>/<script>.nsi). Got: $nsiPath"
        exit 1
    }

    # alien-isolation/enhancement-pack.nsi
    $exeName = $parts[1]

    # alien-isolation/enhancement-pack.nsi => alien-isolation-enhancement-pack.exe
    $exeName = (($exeName -replace '\.nsi$', '') -replace '/', '-') + ".exe"

    return $exeName
}

if (-not (Test-Path "nsis\makensis.exe")) {
	Write-Host "Error: makensis.exe not found. Please run setup.ps1 first."
	exit 1
}

if (-not (Test-Path $nsiPath)) {
	Write-Host "Error: NSI file not found: $nsiPath"
	exit 1
}

$exeName = GenerateExeName $nsiPath
New-Item -ItemType Directory -Force -Path (Join-Path $PSScriptRoot "..\dist") | Out-Null
$exePath = Join-Path $PSScriptRoot "..\dist\$exeName"

$process = Start-Process `
	-FilePath "nsis\makensis.exe" `
    -ArgumentList @("/X`"OutFile `"$exePath`"`"", $nsiPath) `
	-Wait `
    -NoNewWindow `
    -PassThru

if ($process.ExitCode -ne 0) {
    exit $process.ExitCode
}

if ($sign) {
    $signtoolPath = "C:/Program Files (x86)/Microsoft SDKs/ClickOnce/SignTool/signtool.exe"
    if (-not (Test-Path $signtoolPath)) {
        Write-Host "Error: signtool.exe not found."
        exit 1
    }

    if (-not (Test-Path "mulderload.pfx")) {
        Write-Host "Error: mulderload.pfx not found. Please set CERTIFICATE_BASE64 environment variable and run setup.ps1 first."
        exit 1
    }

    if (-not $Env:CERTIFICATE_PASSWORD) {
        Write-Host "Error: CERTIFICATE_PASSWORD environment variable not set."
        exit 1
    }

    $process = Start-Process `
        -FilePath "$signtoolPath" `
        -ArgumentList @(
            "sign",
            "/f", "mulderload.pfx",
            "/p", "$Env:CERTIFICATE_PASSWORD",
            "/t", "http://timestamp.digicert.com",
            "/fd", "sha256",
            # "/td", "sha256", not working with this cert
            $exePath
        ) `
        -Wait `
        -NoNewWindow `
        -PassThru

    if ($process.ExitCode -ne 0) {
        exit $process.ExitCode
    }
}

Pop-Location

exit 0
