!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Metal Gear Solid 4, aiming to provide a modern vanilla experience. It includes:$\r$\n\
- Various improvements: MGSPatriotFix by ShizCalev$\r$\n\
- Audio improvement: Uncompressed PS3 Audio by Afevis$\r$\n\
- FPS Unlocker: MGSFPSUnlock by cipherxof$\r$\n\
- Ultrawide && FOV Modifier: MGS4 Ultra120 by drbermejor$\r$\n\
- Level statistics: MGS4 Stats Overlay by ien646$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to ShizCalev && drbermejor!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Metal Gear Solid 4 [Enhancement Pack]"

Section "MGSPatriotFix (by ShizCalev)"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/ShizCalev/MGSPatriotFix/releases/download/0.2.2/MGS4_MGSPatriotFix_0.2.2.zip" \
                            "https://www.nexusmods.com/metalgearsolid4mc/mods/1?tab=files&file_id=188" \
                            "MGS4_MGSPatriotFix_0.2.2.zip" \
                            "4f8fa5dd493c9d5d023fd4dfdcad39a2259b2aedf02685840751c263f497a6b1"

    !insertmacro NSISUNZ_EXTRACT "MGS4_MGSPatriotFix_0.2.2.zip" ".\" "AUTO_DELETE"
    AddSize 17818

    File "resources\MGSPatriotFix.settings"
SectionEnd

SectionGroup /e "Improvements configurable via MulderConfig"
    Section "MGSFPSUnlock (by cipherxof)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\MGSFPSUnlock\MGS4\scripts"

        !insertmacro DOWNLOAD_2 "https://github.com/cipherxof/MGSFPSUnlock/releases/download/0.1.3/MGSFPSUnlock.zip" \
                                "https://www.nexusmods.com/metalgearsolid4mc/mods/19?tab=files&file_id=61" \
                                "MGSFPSUnlock.zip" \
                                "b3a558e98513c173bcf65e4a8da201f645ce7fdd01c5b09a946a34876ce9b3de"

        !insertmacro NSISUNZ_EXTRACT_ONE "MGSFPSUnlock.zip" ".\" "scripts\MGSFPSUnlock.asi" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "MGSFPSUnlock.zip" "$INSTDIR\MGS4\scripts" "scripts\MGSFPSUnlock.ini" "AUTO_DELETE"
        AddSize 1669
    SectionEnd

    Section "MGS4 Stats Overlay (by ien646)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\MGS4StatsOverlay\MGS4\scripts"

        !insertmacro DOWNLOAD_2 "https://github.com/ien646/mgs4-vv-mirror/releases/download/0.2/mgs4-vv.asi" \
                                "https://cdn.mulderload.eu/games/metal-gear-solid-4-guns-of-the-patriots-master-collection-version/impr_misc/mgs4-vv.asi" \
                                "mgs4-vv.asi" \
                                "bbc2a23ff158dd7ea38b4cabe5b466f451a38f5d51b734899bf6068e84408647"
        AddSize 2498
    SectionEnd

    Section "MGS4 Ultra120 (by drbermejor)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\MGS4Ultra120\MGS4\scripts"

        !insertmacro DOWNLOAD_2 "https://github.com/drbermejor/mgs4Ultra120/releases/download/v0.3.4-alpha.7/MGS4Ultra120-v0.3.4-alpha.7-windows-manual.zip" \
                                "https://cdn.mulderload.eu/games/metal-gear-solid-4-guns-of-the-patriots-master-collection-version/impr_gfx/MGS4Ultra120-v0.3.4-alpha.7-windows-manual.zip" \
                                "MGS4Ultra120.zip" \
                                "19391aabbcce9643312c33a5aed696075e6b1b538f277d716d440ff5ba6e2d55"

        !insertmacro NSISUNZ_EXTRACT_ONE "MGS4Ultra120.zip" ".\" "MGS4Ultra120-v0.3.4-alpha.7-windows-manual\scripts\MGS4NativeCenteredHUD.asi" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "MGS4Ultra120.zip" ".\" "MGS4Ultra120-v0.3.4-alpha.7-windows-manual\scripts\MGS4Ultra120.asi" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "MGS4Ultra120.zip" "$INSTDIR\MGS4\" "MGS4Ultra120-v0.3.4-alpha.7-windows-manual\mgs4_native_centered_hud.ini" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "MGS4Ultra120.zip" "$INSTDIR\MGS4\" "MGS4Ultra120-v0.3.4-alpha.7-windows-manual\mgs4_ultrawide.ini" "AUTO_DELETE"
        AddSize 350

        !insertmacro FILE_STR_REPLACE "Enabled=0" "Enabled=1" 1 1 "$INSTDIR\MGS4\mgs4_native_centered_hud.ini"
    SectionEnd

    Section
        !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
    SectionEnd
SectionGroupEnd

Section /o "Uncompressed PS3 Audio (by Afevis)"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/metalgearsolid4mc/mods/38?tab=files&file_id=62" \
                            "Uncompressed PS3 Music 38 1.0.0 2026-09-02T03-31Z cp4ghskqZ.zip" \
                            "72086313bcdd943f3e302f1a055c0390da4f9ec1"

    !insertmacro 7Z_GET
    !insertmacro 7Z_EXTRACT "Uncompressed PS3 Music 38 1.0.0 2026-09-02T03-31Z cp4ghskqZ.zip" ".\" "AUTO_DELETE"
    !insertmacro 7Z_REMOVE
    AddSize 7745385
SectionEnd

Section
    RMDir /r "$INSTDIR\@mulderload"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "mgs4.exe"
    StrCpy $SELECT_RELATIVE_PATH "MGS4"
    StrCpy $SELECT_STEAM_FOLDER "METAL GEAR SOLID 4"
FunctionEnd
