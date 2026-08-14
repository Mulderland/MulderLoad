Bioshock Remastered *Enhancement Pack* @ mulderland.com
------------------------------------------------------------------------------------------------------------------------

1) Known Issues

1.1) Floating arm in ultrawide resolutions

When using the wrench in ultrawide resolutions, the player's arm may appear to float.
There is currently no known fix.

1.2) Crashes

If the game crashes, try the following solutions, in order:
- (Windows only) Enable DXVK in MulderConfig, then click "Save" and "Apply".
- (Windows only) Limit the game to 4 CPU cores. In Steam, right-click the game, Properties, Launch Options:
cmd /c start "" /affinity f %command%
- Uninstall the HD Texture Pack (see section 2.4).

1.3) Resolutions not listed when using DXVK

This can happen when using DXVK in a multi-monitor setup. DXVK only lists the resolutions available on the "first" 
monitor, which is not always the monitor you're playing on. As a result, you may not be able to select the resolution
you want in-game.

This is a known limitation of DXVK on Windows. There is no real fix, but you can work around the issue by disabling 
your other monitors before launching the game.

------------------------------------------------------------------------------------------------------------------------

2) TFCInstaller

Some graphical mods cannot be enabled through MulderConfig and must instead be installed with TFCInstaller.

TFCInstaller has been installed in:
<Game Directory>\TFCInstaller

If TFCInstaller fails to start because of a missing .NET dependency, open the "redist" subfolder inside "TFCInstaller" 
and install the included runtime.

2.1) Installing the graphical mods

IMPORTANT: The installation order matters.

To avoid mistakes, the installer has placed the four mods in the "TFC Mods" folder with the correct installation order.

Installation steps:
- Click "Game Folder" and select your BioShock Remastered installation directory.
- Click "Mod Folder" and browse to the "TFC Mods" folder.
- Select "01 - HD Texture Pack v1.0" and click "Select Folder".
- Click "Update BioShock Remastered" and wait a few minutes. This is the largest mod, so it takes time.
- Click "Mod Folder" again, select "02 - Visual Fixes v2.3.1", then click "Update BioShock Remastered".
- Repeat the process with "03 - Reflective Water Surface v2.2".

Note: If you didn't select the HD Texture Pack in the installer, you won't have the "01 - HD Texture Pack v1.0" folder.
In that case, simply start with "02 - Visual Fixes v2.3.1".

2.2) Installing the "Disable Headbob" mod

This optional mod is recommended only if you experience motion sickness.

Installation steps:
- Click "Mod Folder".
- Select "04 - Disable Headbob v1.0".
- Click "Update BioShock Remastered".

2.3) Uninstalling the "Disable Headbob" mod

Click "Restore Backup" and select the previous backup, which should be named "03 - Reflective Water Surface v2.2"

2.4) Uninstalling the HD Texture Pack

If you experience crashes and suspect the HD Texture Pack is the cause:

Click "Uninstall All".
Reinstall the remaining mods, starting with "02 - Visual Fixes v2.3.1" (skip the HD Texture Pack).

2.5) Save space

TFCInstaller creates a backup every time you install a mod. Since the HD Texture Pack is very large, it significantly 
increases the size of the backup, and all future backups will be much larger as well.

I don't recommend deleting the backups, as restoring your game would then require a clean reinstall through Steam.
However, if you really need to save disk space, you can delete the TFCInstallerBackup folder.

------------------------------------------------------------------------------------------------------------------------

3) MulderConfig

MulderConfig is the configuration tool bundled with most Mulderland Enhancement Packs.

For this game, MulderConfig is only used for two things:
- Switching between Direct3D and Vulkan (DXVK).
- Enabling the "No Dot and Minimal HUD" mod, which I recommend if you want a more immersive experience.
