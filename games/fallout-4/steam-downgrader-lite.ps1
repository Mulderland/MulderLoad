# Disable progress bar
$ProgressPreference = 'SilentlyContinue'

Invoke-WebRequest -Uri "https://cdn2.mulderload.eu/g/fallout-4/steam-downgrader-lite/steam_depots_deltas.zip" -OutFile "steam_depots_deltas.zip"
$hash = (Get-FileHash -Path ".\steam_depots_deltas.zip" -Algorithm SHA1 | Select-Object -ExpandProperty Hash).ToLower()
if ($hash -ne "596cf966a52c0ac8af35d5883024a866d62554c3") {
    Write-Host "Error: downloaded file hash does not match expected value. Aborting."
    exit 1
}
Expand-Archive -Path ".\steam_depots_deltas.zip" -DestinationPath ".\resources-downgrader-lite" -Force
Remove-Item ".\steam_depots_deltas.zip" -Force

exit 0
