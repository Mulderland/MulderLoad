!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Crimson Moon to:$\r$\n\
- Correct the FOV on Ultrawide (21/9 and 32/9)$\r$\n\
- Change the FOV for normal resolution too$\r$\n\
- Skip the intro logos$\r$\n\
$\r$\n\
Everything is configurable via the MulderConfig UI.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Thanks to Gametism, ThirteenAG, PhantomGamers, and SRes for his ultrawide tutorial on the Steam forums!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Crimson Moon [Enhancement Pack]"

SectionGroup /e "Improvements configurable via MulderConfig"
    Section "No-Intro v0.2 (by Gametism)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\NoIntro"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/crimsonmoon/mods/3?tab=files&file_id=14" \
                                "CMNo-IntroFix-v.0.2 3 0.2 2026-10-06T13-17Z Qqhe9F6M3.zip" \
                                "e0f032c355cfc9eb48fe7d038b46cecca663c2dce8f2d7f5cfced7cdc5158903"

        !insertmacro NSISUNZ_EXTRACT "CMNo-IntroFix-v.0.2 3 0.2 2026-10-06T13-17Z Qqhe9F6M3.zip" ".\" "AUTO_DELETE"
        AddSize 57
    SectionEnd

    Section "Somewhat Universal Widescreen Fix v2.3.0 (by PhantomGamers)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\SUWSF"

        !insertmacro DOWNLOAD_1 "https://github.com/PhantomGamers/SUWSF/releases/download/2.3.0/SUWSF-x64.zip" \
                                "SUWSF-x64.zip" \
                                "2f0831cba476f014819282e92b870156dbf964c8cc6d6412cd68040bee1612a0"

        !insertmacro NSISUNZ_EXTRACT_ONE "SUWSF-x64.zip" ".\" "SUWSF.asi" "AUTO_DELETE"
        File "resources\SUWSF.ini"
        AddSize 656
    SectionEnd

    Section "Ultimate ASI Loader v10.0.5 (by ThirteenAG)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\UltimateASILoader"

        !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/v10.0.5/Ultimate-ASI-Loader_x64.zip" \
                                "Ultimate-ASI-Loader_x64.zip" \
                                "0da70825976f4b051e45de10adffcea35e952b8ac58bfda4f5b9e4bef1d9ba4b"

        !insertmacro NSISUNZ_EXTRACT "Ultimate-ASI-Loader_x64.zip" ".\" "AUTO_DELETE"
        AddSize 7303
    SectionEnd

    Section
        !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "CrimsonMoonNG.exe"
    StrCpy $SELECT_STEAM_FOLDER "Crimson Moon"
FunctionEnd
