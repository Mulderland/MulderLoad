Dishonored *Enhancement Pack* @ mulderland.com
------------------------------------------------------------------------------------------------------------------------

1) Known Issues

1.1) "Dunwall City Trials" DLC scores cannot be posted to the leaderboard

This is a known issue that occurs when the game's INI files have been modified.
Before playing Dunwall City Trials, I recommend disabling all options in the INI Tweaks section of MulderConfig.

1.2) Crashes

If the game crashes, try the following solutions in order:
- Disable "Texture Quality: Max" in MulderConfig
- Disable "Level of Detail: Max", "Lighting Quality: Max", "Shadow Quality: Max" in MulderConfig
- Uninstall the "Definitive Edition Asset Pack" (PS4 Texture Pack), if installed (see Section 2.2)

------------------------------------------------------------------------------------------------------------------------

2) TFCInstaller

Some mods cannot be enabled through MulderConfig and must instead be installed with TFCInstaller.

TFCInstaller has been installed in:
<Game Directory>\TFCInstaller

If TFCInstaller fails to start because of a missing .NET dependency, open the "redist" subfolder inside "TFCInstaller" 
and install the included runtime.

2.1) Installing the TFC mods

I highly recommend installing at least "01 - Skippable Cutscenes v1.0".
"02 - Disable crouch vignette v1.0" removes the darkening at the bottom of the screen when crouching.
"03 - Disable pickup glow v1.3" removes the glow effect around pickupable objects.
"04 - Definitive Edition Asset Pack v1.1" is the PS4 Texture Pack. It is by far the largest mod, so I placed it last to
reduce the size of TFCInstaller's backups and make it easy to disable if necessary.

Installation steps:
- Click "Game Folder" and select your Dishonored installation directory.
- Click "Mod Folder" and browse to the "TFC Mods" folder.
- Select "01 - Skippable Cutscenes v1.0" and click "Select Folder".
- Click "Update Dishonored + DLCs" and wait a few seconds for the process to complete.
- To install another TFC Mod, click "Mod Folder" again and repeat the process.

Note: Don't be surprised if you don't see the "Update Dishonored + DLCs" button when installing 
"05 - Definitive Edition Asset Pack v1.1 (DLC5)". Just click "Update Dunwall City Trials" instead.

2.2) Uninstalling the PS4 Texture Pack

If you experience crashes and suspect the PS4 Texture Pack is the cause:

Click "Restore Backup".
Select the backup created before "04 - Definitive Edition Asset Pack v1.1 (Base)"
(If you installed all the TFC Mods in order, this should be "03 - Disable pickup glow v1.3")

------------------------------------------------------------------------------------------------------------------------

3) MulderConfig

You can quickly toggle multiple mods and apply all available INI tweaks using MulderConfig.
Simply run "MulderConfig.exe", located in the game installation folder.

Once you have finished making your selections, be sure to click "Save" to save your preferences in MulderConfig, 
and "Apply" to apply your settings to the game.
