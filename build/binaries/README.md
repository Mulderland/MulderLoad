# Bundled binaries (.binaries)

This folder contains third-party binaries that are required by the build/install scripts and are intentionally checked into the repository to make builds more reliable.

Reasons we bundle these:
- Some URLs can be flaky (e.g. SourceForge downloads randomly fail).
- Some software isn’t easily available in a reliable “direct download” form (e.g. getting the full `7z.exe`, not just `7za.exe` which supports fewer formats).

## What’s included

Hashes below are SHA-1.

- `7z-v25.01.zip` - 7-Zip CLI - e1b06195495999f6a966631c76fa38eb1955285a
- `nsis-3.11-setup.exe` - NSIS installer - a64bbad73d4638d668ffdbd0887be7d6528d6a9d
- `Nsis7z_19.00.7z` - NSIS 7z plugin - a2423c9f92c21462aae1f42708e75afef4b226dc
- `NSISunzU.zip` - NSIS unzip plugin - 10c03c2cbf2be4531eebed35905c650c7a0dc381

## Sources

- 7-Zip: https://7-zip.org/
- NSIS 7z plugin: https://nsis.sourceforge.io/Nsis7z_plug-in
- NSIS unzip plugin: https://nsis.sourceforge.io/Nsisunz_plug-in

## Not bundled (downloaded during build)

- nsis-nscurl: https://github.com/negrutiu/nsis-nscurl
