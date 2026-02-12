param (
    [Parameter(Mandatory = $true)]
    [string]$FromCommit,

    [Parameter(Mandatory = $true)]
    [string]$ToCommit
)

$ErrorActionPreference = "Stop"
Push-Location $PSScriptRoot

$changedFiles = git diff --name-only $FromCommit $ToCommit

$rebuildAll = $false

foreach ($file in $changedFiles) {

    if ($file -match '^\.github/') {
        $rebuildAll = $true
        break
    }

    if ($file -match '^build/' -and -not $file.EndsWith('.md')) {
        $rebuildAll = $true
        break
    }

    if ($file -match '^includes/') {
        $rebuildAll = $true
        break
    }

    if ($file -eq 'MulderLoad.ico') {
        $rebuildAll = $true
        break
    }
}

if ($rebuildAll) {
    $nsiFiles = Get-ChildItem -Path "../games" -Recurse -Filter "*.nsi" | ForEach-Object { $_.FullName }
}
else {
    $changedGameDirs = @()

    foreach ($changedFile in $changedFiles) {
        if ($changedFile -match '^games/([^/]+)/') {
            $changedGameDirs += $matches[1]
        }
    }

    $changedGameDirs = $changedGameDirs | Sort-Object -Unique

    $nsiFiles = @()

    foreach ($game in $changedGameDirs) {
        $path = "../games/$game"
        if (Test-Path $path) {
            $nsiFiles += Get-ChildItem -Path $path -Recurse -Filter "*.nsi" | ForEach-Object { $_.FullName }
        }
    }

    $nsiFiles = $nsiFiles | Sort-Object -Unique
}

# Result summary 
if ($nsiFiles.Count -eq 0) {
    $detectSummary = "none"
} elseif ($rebuildAll) {
    $detectSummary = "all"
} else {
    $detectSummary = "partial"
}
Write-Host "Detection summary: $detectSummary"
if ($env:GITHUB_OUTPUT) {
    "detectSummary=$detectSummary" >> $env:GITHUB_OUTPUT
}

# Result details (in .txt)
If (Test-Path "detect_result.txt") {
    Remove-Item "detect_result.txt"
}
if ($nsiFiles.Count -gt 0) {
    $nsiFiles | Out-File -FilePath detect_result.txt -Encoding utf8
}

Pop-Location 
