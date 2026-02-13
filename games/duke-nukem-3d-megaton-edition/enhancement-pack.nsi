!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Duke Nukem 3D: Megaton Edition. It includes:$\r$\n\
- eduke32 (source port)$\r$\n\
- 4 High Resolution Packs (including Hendricks266's)$\r$\n\
- AI Upscale Pack v1.3 (by phredreeke)$\r$\n\
- MulderConfig for game/addons configuration$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the eduke32 team and the HRP community for their dedicated work all these years!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\bin\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Duke Nukem 3D: Megaton Edition [Enhancement Pack]"

Section "eDuke32 (x64)"
    SectionIn RO
    SetOutPath "$INSTDIR\eduke32"
    AddSize 19000

    !insertmacro DOWNLOAD_2 "https://dukeworld.com/eduke32/synthesis/20251111-10652-39967d866/eduke32_win64_20251111-10652-39967d866.7z" \
                            "https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/eduke32_win64_20251111-10652-39967d866.7z" \
                            "eduke32.7z" "a7f0baf0e39d9d025031639718a3aa57d9b7d420"
    !insertmacro NSIS7Z_EXTRACT "eduke32.7z" ".\" "AUTO_DELETE"
SectionEnd

SectionGroup /e "HD Textures" fov
    Section "HRPs (High Resolution Packs)"
        AddSize 1111490
        SetOutPath "$INSTDIR\gameroot"

        !insertmacro DOWNLOAD_2 "http://www.duke4.org/files/nightfright/hrp/duke3d_hrp.zip" \
                                "https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/duke3d_hrp.zip" \
                                "duke3d_hrp.zip" "49a75902d63b58c0eb38d968d277db3e3d81e212"

        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/te2y8oqzmzhnmho/duke3d_megaton_hrp_override_custom.zip/file" \
                                "https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/duke3d_megaton_hrp_override_custom.zip" \
                                "duke3d_megaton_hrp_override_custom.zip" "eff53e1d016109c0970d44e5a9f5706790ee36bc"

        !insertmacro DOWNLOAD_2 "http://www.duke4.org/files/nightfright/related/dukedc_hrp.zip" \
                                "https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/dukedc_hrp.zip" \
                                "dukedc_hrp.zip" "5956ada8a53516069a48b312732e532a0caefa00"

        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/p82zauxyzxgu959/nwinter_hrp.zip/file" \
                                "https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/nwinter_hrp.zip" \
                                "nwinter_hrp.zip" "d8431f7763f79497f431b603aa1568b6e6c92b51"

        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/5xu2p51z5y42hpd/vacation_hrp.zip/file" \
                                "https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/vacation_hrp.zip" \
                                "vacation_hrp.zip" "6584ba51dd848fdbd527413916a67016551cc40e"

        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/no16k588lgjak1o/classic_monsters.zip/file" \
                                "https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/classic_monsters.zip" \
                                "classic_monsters.zip" "80688c573b15f0d1eb6bacc54c4a96edf9b7877d"

        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/gaiqdzm2t0fn9h1/classic_weapons.zip/file" \
                                "https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/classic_weapons.zip" \
                                "classic_weapons.zip" "9607e23befcf8757fbedc96ee866477468f5e35a"
    SectionEnd

    Section "AI Upscale Pack v1.3"
        AddSize 103140
        SetOutPath "$INSTDIR\gameroot"

        # https://www.moddb.com/games/duke-nukem-3d/addons/duke-nukem-3d-upscale-pack-13
        !insertmacro DOWNLOAD_2 "https://www.moddb.com/addons/start/204547" \
                                "https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/dukeupscale.zip" \
                                "dukeupscale.zip" "2eb0b06cab9f436f6276829662142fab"
    SectionEnd
SectionGroupEnd

SectionGroup /e "MulderConfig (latest)"
    Section
        SectionIn RO
        AddSize 1024
        SetOutPath "$INSTDIR\bin"
        !insertmacro DOWNLOAD_1 "https://github.com/mulderload/MulderConfig/releases/latest/download/MulderConfig.exe" "MulderConfig.exe" ""
        File resources\MulderConfig.json
        File resources\MulderConfig.save.json
        ExecWait '"$INSTDIR\bin\MulderConfig.exe" -apply' $0
    SectionEnd

    Section /o "Microsoft .NET Desktop Runtime 8.0.23 (x64)"
        SetOutPath "$INSTDIR"
        AddSize 100000
        !insertmacro DOWNLOAD_2 "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/8.0.23/windowsdesktop-runtime-8.0.23-win-x64.exe" \
                                "https://cdn2.mulderload.eu/g/_redist/windowsdesktop-runtime-8.0.23-win-x64.exe" \
                                "windowsdesktop-runtime-win-x64.exe" "0ecfc9a9dab72cb968576991ec34921719039d70"
        ExecWait '"windowsdesktop-runtime-win-x64.exe" /Q' $0
        Delete "windowsdesktop-runtime-win-x64.exe"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "duke3d.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Duke Nukem 3D\bin"
    StrCpy $SELECT_RELATIVE_INSTDIR ".."
FunctionEnd
