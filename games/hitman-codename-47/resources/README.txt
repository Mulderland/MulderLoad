Hitman: Codename 47 *Enhancement Pack* @ mulderland.com
------------------------------------------------------------------------------------------------------------------------

1) Known Issues

1.1) Mouse cursor not responding at launch

If "UI Scaling" and/or "Borderless Windowed Fullscreen" is enabled, the mouse cursor may not respond when the game starts.

Solution:
- Simply press Alt + Tab twice.

------------------------------------------------------------------------------------------------------------------------

1.2) Fatal error: Direct3D: Unable to find a suitable display mode for true color.

This issue is related to the UI Scaling feature. It occurs when the selected "UI resolution" (defined in 
scripts\HitmanCodename47WidescreenFix.ini) doesn't exist on your system.

Try the following solutions in order:
- Set "Borderless Windowed Fullscreen"
- Set "UI Scaling x1"
- Set "Borderless Windowed Fullscreen" and "UI Scaling x1"
- Choose another solution
- (Advanced) Manually create the required "HUD resolution" in your GPU control panel. See the ini to know which one.
- Run setup.exe and try OpenGL

------------------------------------------------------------------------------------------------------------------------

1.3) Game displayed in the bottom-right corner of the screen

This can happens when using "Borderless Windowed Fullscreen" + a display scaling above 100% in Windows settings

Try the following solutions in order:
- Set "Exclusive Fullscreen"
- Set Windows Display Scaling to 100%

------------------------------------------------------------------------------------------------------------------------

1.4) Text artifacts when using UI Scaling

Enabling UI Scaling can create visual artifacts on text elements. This becomes particularly noticeable at x3 scaling.

There is currently no fix.
For best results, it is recommended to stay at x2.

------------------------------------------------------------------------------------------------------------------------

1.5) Game is not running fullscreen (OpenGL)

This occurs because "UI Scaling" is not supported with OpenGL, and a "UI Scaling" option (different than x1) was
previously selected in MulderConfig.

When using OpenGL, the "UI Scaling" must be "x1 (default)"

Solution:
- Run MulderConfig
- Set "UI Scaling" to "x1 (default)"
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
- When using OpenGL renderer, limit the framerate to 60 FPS in your GPU control panel, or with a software like
MSIAfterBurner, or set your monitor to 60Hz + enable VSync.

------------------------------------------------------------------------------------------------------------------------

3) Advanced

3.1) Custom Resolution

If your resolution isn't listed, select "Other" and manually set it by editing the 
scripts\HitmanCodename47WidescreenFix.ini file.

Please note that if you're using "UI Scaling" at x2, you’ll need to divide both the "Width" and "Height" values by 2.
And if you're using an "UI Scaling" at x3, you’ll need to divide both the "Width" and "Height" values by 3.

WARNING about x3:
For a clean and sharp result, always use scaling factors that produce integer values.
If the division results in decimal numbers, the UI may appear misaligned or slightly distorted.

------------------------------------------------------------------------------------------------------------------------

4) Credits & Thanks

This Enhancement Pack was assembled and packaged by Mulder

Special thanks to:
- alphayellow for the Widescreen & FOX fix (and for adding OpenGL support so quickly!)
- ThirteenAG for the Ultimate ASI Loader
- the dgVoodoo2 team
Without their work, this pack would not have been possible.

Find other Enhancement Packs (and more) at www.mulderland.com
