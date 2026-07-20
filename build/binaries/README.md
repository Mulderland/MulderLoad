# Bundled binaries (.binaries)

This folder contains third-party binaries that are required by the build/install scripts and are intentionally checked into the repository to make builds more reliable.

Reasons we bundle these:
- Some URLs can be flaky (e.g. SourceForge downloads randomly fail).
- Some software isn’t easily available in a reliable “direct download” form (e.g. getting the full `7z.exe`, not just `7za.exe` which supports fewer formats).

## What’s included

Hashes below are SHA-1.

- `7z-v26.02.zip` - 7-Zip CLI - 591e5377407ce18b4f9f8ed67c7d5b4e42a81821
- `nsis-3.12-setup.exe` - NSIS installer - 6381316aa3f8203688082c0b88fc5ff304c89b69
- `Nsis7z_19.00.7z` - NSIS 7z plugin - a2423c9f92c21462aae1f42708e75afef4b226dc
- `NSISunzU.zip` - NSIS unzip plugin - 10c03c2cbf2be4531eebed35905c650c7a0dc381

## Sources

- 7-Zip: https://7-zip.org/
- NSIS 7z plugin: https://nsis.sourceforge.io/Nsis7z_plug-in
- NSIS unzip plugin: https://nsis.sourceforge.io/Nsisunz_plug-in

## Not bundled (downloaded during build)

- nsis-nscurl: https://github.com/negrutiu/nsis-nscurl
