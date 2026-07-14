# Disable progress bar
$ProgressPreference = 'SilentlyContinue'

Invoke-WebRequest -Uri "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_lite/steam_depots_deltas.zip" -OutFile "steam_depots_deltas.zip"
$hash = (Get-FileHash -Path ".\steam_depots_deltas.zip" -Algorithm SHA1 | Select-Object -ExpandProperty Hash).ToLower()
if ($hash -ne "a0b24551b78ae273a0cad0eea351b10735724d41") {
    Write-Host "Error: downloaded file hash does not match expected value. Aborting."
    exit 1
}
Expand-Archive -Path ".\steam_depots_deltas.zip" -DestinationPath ".\resources-downgrader-lite" -Force
Remove-Item ".\steam_depots_deltas.zip" -Force

Invoke-WebRequest -Uri "https://github.com/jmacd/xdelta-gpl/releases/download/v3.0.11/xdelta3-3.0.11-x86_64.exe.zip" -OutFile "xdelta3.zip"
Expand-Archive -Path ".\xdelta3.zip" -DestinationPath ".\resources-downgrader-lite" -Force
Remove-Item ".\xdelta3.zip" -Force

exit 0
