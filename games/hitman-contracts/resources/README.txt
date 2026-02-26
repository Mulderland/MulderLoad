Hitman: Contracts *Enhancement Pack* @ mulderland.com
------------------------------------------------------------------------------------------------------------------------

1) Known Issues

1.1) Fatal error: Direct3D: Unable to create device. Try changing resolution or color depth.

This issue may be related to the "UI Scaling" feature. It occurs when the selected "UI resolution" (defined in 
scripts\h3.ini) doesn't exist on your system.

Try the following solutions in order:
- Set "Borderless Windowed Fullscreen"
- Set "UI Scaling x1"
- Set "Borderless Windowed Fullscreen" and "UI Scaling x1"
- Choose another resolution
- (Advanced) Manually create the required "UI resolution" in your GPU control panel. See the ini to know which one.

------------------------------------------------------------------------------------------------------------------------

1.2) My system can't maintain 60 FPS

To improve performance, you can
- disable "post-processing effects" in the game menu
- and/or avoid using the "HUD Scaling: x2 (best quality)" setting, as it uses supersampling and is resource-intensive.

------------------------------------------------------------------------------------------------------------------------

1.3) UI Scaling "x2 (best quality)" reduces Steam Overlay size

This behavior is expected, and there is no fix available.

Explanation: Post-filter effects do not scale properly. To prevent a degradation in quality, the "Best Quality" setting
uses "supersampling." While this helps maintain the integrity of the post-filter effects, it is resource-intensive and
causes the Steam Overlay to appear smaller than usual.

------------------------------------------------------------------------------------------------------------------------

2) Advanced

2.1) Custom Resolution

If your resolution isn't listed, select "Other" and manually set it by editing the scripts\h3.ini file.

Please note that if you're using "UI Scaling" at x2, you’ll need to divide both the "Width" and "Height" values by 2.

------------------------------------------------------------------------------------------------------------------------

3) Credits & Thanks

This Enhancement Pack was assembled and packaged by Mulder

Special thanks to:
- nemesis2000 for the Widescreen fix
- ThirteenAG for the Ultimate ASI Loader
- the dgVoodoo2 team
- burntshrimp for importing missing Direct3D effects from the OpenGL version
- mutantx20 for the controller support
Without their work, this pack would not have been possible.

Find other Enhancement Packs (and more) at www.mulderland.com
