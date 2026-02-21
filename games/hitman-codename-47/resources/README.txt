Hitman: Codename 47 *Enhancement Pack* @ mulderland.com
------------------------------------------------------------------------------------------------------------------------

1) Known Issues

1.1) Mouse cursor not responding at launch

If "HUD Scaling" is enabled in MulderConfig, the mouse cursor may not respond when the game starts.

Solution:
- Simply press Alt + Tab twice.

------------------------------------------------------------------------------------------------------------------------

1.2) Fatal error: Direct3D: Unable to find a suitable display mode for true color.

This issue is related to the HUD Scaling feature. It occurs when the selected "HUD resolution" (defined in 
scripts\HitmanCodename47WidescreenFix.ini) doesn't exist on your system.

Try the following solutions in order:
- Disable "Run Fullscreen" in Setup.exe (the game will run in borderless fullscreen)
- Select another "HUD Scaling" setting in MulderConfig
- (Advanced) Manually create the required "HUD resolution" in your GPU control panel. See the ini to know which one.

------------------------------------------------------------------------------------------------------------------------

1.3) Game displayed in the bottom-right corner of the screen

This can happens when using "Borderless window" + a display scaling above 100% in Windows settings

Try the following solutions in order:
- Enable "Run Fullscreen" in Setup.exe
- Set Windows Display Scaling to 100%

------------------------------------------------------------------------------------------------------------------------

1.4) Text artifacts when using HUD Scaling

Enabling HUD Scaling can create visual artifacts on text elements. This becomes particularly noticeable at x3 scaling.

There is currently no fix.
For best results, it is recommended to stay at x2.

------------------------------------------------------------------------------------------------------------------------

1.5) Game is not running fullscreen (OpenGL)

This occurs because HUD Scaling is not supported with OpenGL, and a HUD scaling option was previously selected.
When using OpenGL, the HUD must remain at its original resolution.

Solution:
- Run MulderConfig
- Set "HUD Scaling" to "Default (original)"
- Click Apply

------------------------------------------------------------------------------------------------------------------------

2) Precautions & Recommendations

2.1) Anti-Aliasing

Do not enable Anti-Aliasing in dgVoodooCpl. It will increase text artifacts.
If you want smoother edges, you may enable FXAA in your GPU control panel instead.

------------------------------------------------------------------------------------------------------------------------

2.2) Avoid framerates higher than 60 FPS

High FPS can cause gameplay bugs and camera bugs.

Recommended setup:
- When using Direct3D renderer: FPS is already properly limited (by dgVoodoo2)
- When using OpenGL renderer, limit the framerate to 60 FPS in your GPU control panel (or set your monitor to 60Hz + VSync)

------------------------------------------------------------------------------------------------------------------------

3) Advanced

3.1) Manual HUD Scaling

The HUD Scaling feature relies on dgVoodoo2, with the Resolution setting configured to "Desktop" (meaning the game
renders at your actual desktop resolution).

For example:
- If your desktop resolution is 1920x1080
- And you select x2 scaling in MulderConfig
- MulderConfig simply modifies the file "scripts\HitmanCodename47WidescreenFix.ini" and set Width = 960, Height = 540
(your resolution divided by your scaling factor)

If your resolution is not listed in MulderConfig, you can apply the same logic manually.

IMPORTANT:
For a clean and sharp result, always use scaling factors that produce integer values.
If the division results in decimal numbers, the UI may appear misaligned or slightly distorted.

------------------------------------------------------------------------------------------------------------------------

3.2) Modifying Rendering Resolution

In most cases, your Rendering Resolution should match your Desktop Resolution.
With the default configuration, this is already handled automatically (both in Direct3D and OpenGL).
Only change this if you know what you are doing.

OpenGL renderer (HUD Scaling is not available in OpenGL mode)
- Edit scripts\HitmanCodename47WidescreenFix.ini
- Adjust the resolution values manually

Direct3D renderer
- Open dgVoodooCpl
- Go to the DirectX tab
- Change the Resolution setting there

------------------------------------------------------------------------------------------------------------------------

4) Credits & Thanks

This Enhancement Pack was assembled and packaged by Mulder

Special thanks to:
- alphayellow for the Widescreen & FOX fix (and for adding OpenGL support so quickly!)
- ThirteenAG for the Ultimate ASI Loader
- the dgVoodoo2 team
Without their work, this pack would not have been possible.

Find other Enhancement Packs (and more) at www.mulderland.com
