Ultrawide Patch for bbport-windows (supermedo's fork of bbport)
---------------------------------------------------------------

1) Introduction

This is a configuration tool that applies an Ultrawide patch to Bloodborne, allowing you to play at ultrawide resolutions with an optional HUD repositioning feature.

Limitations:
- No upscaling support: The current patches do not support upscaling. See Why not use upscaling? for more details.
- Anti-aliasing: The game's built-in anti-aliasing is automatically disabled by this patch. It will force you to use DLAA or FSR equivalent native-resolution rendering.
- Configuration: When the ultrawide patch is enabled, bbport.ini is set to read-only to prevent the Bloodborne.exe launcher from overwriting the patch's settings.

---------------------------------------------------------------

2) How to use it

Before enabling Ultrawide, configure your preferences in the Bloodborne.exe launcher, then close it, as it will no longer be able to save any changes (or even create the Steam shortcut).

Open MulderConfig.exe and select your desired ultrawide resolution and anti-aliasing settings.
You can also check the "HUD at screen edges" box. Otherwise, the HUD will remain in its original 16:9 position
Click Save (to save your preferences in MulderConfig), then click Apply (to apply the patch).
Launch the game using "Play Bloodborne.exe" (or your Steam shortcut, if you have already set one up).

---------------------------------------------------------------

3) How to change settings again in the Bloodborne.exe launcher

Open MulderConfig.exe and set both options to No, then uncheck HUD at screen edges.
Click Save and Apply, and close.
MulderConfig will disable the patch and clear the readonly flag on bbport.ini.
You can now use the Bloodborne.exe launcher again.

---------------------------------------------------------------

4) How to uninstall the Ultrawide patch

Follow the steps in the previous section to restore the default settings and make the launcher usable again.
Then delete all MulderConfig* files and the .MulderConfig/ folder.

---------------------------------------------------------------

5) Why not use upscaling?

Upscaling is currently not supported by the available patches. You must use a native-resolution rendering mode, such as DLAA or an equivalent AMD option, instead.
In other words, your rendering resolution must match your output resolution.
If your hardware can't handle your target resolution, you can of course use a lower one.
For reference, I tested 3840×1080 on a 5120×1440 display, and it works.

---------------------------------------------------------------

6) Credits

This Ultrawide patch uses the following:
- Kyo: XML patches
- Dziggy: Ultrawide UI
- Mulder: MulderConfig and the installer
