!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Dino Crysis. It includes:$\r$\n\
- Windows XP Patch$\r$\n\
- High Quality Videos$\r$\n\
- Classic REbirth$\r$\n\
- (optionaly) High Quality Voices and Music (Dreamcast)$\r$\n\
- (optionaly) High Quality Textures (Dreamcast upscaled)$\r$\n\
$\r$\n\
WARNING: make sure you select the Japanese DINO.exe when asked (if using GOG, download the Japanese version)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the Classic REbirth team!"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Dino Crysis [Enhancement Pack]"

Section
    DetailPrint " // Checking that binary is supported"
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\DINO.exe" "2beb1dc79513258ca45116f5933714e1a109c4da" $0 ; Windows XP Patch checksum
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\DINO.exe" "fc27d70a5461d430f51c1b098ac2d38951d0e63a" $1 ; Steam Japanese checksum
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\DINO.exe" "9282dbbcb381188bf1b2e1f6c483dcd82a22ec0a" $2 ; GOG Japanese checksum
    ${If} $0 != "1"
    ${AndIf} $1 != "1"
    ${AndIf} $2 != "1"
        MessageBox MB_ICONEXCLAMATION "Only GOG Japanese release, or the Steam Japanese executable can apply this patch.$\r$\n\
        $\r$\n\
        If you're using GOG, make sure you downloaded the Japanese version of the game.$\r$\n\
        If you're using Steam, make sure you selected the DINO.exe from the $\"japanese$\" folder."
        Quit
    ${EndIf}
SectionEnd

SectionGroup /e "Classic REbirth"
    Section
        !insertmacro 7Z_GET
    SectionEnd

    Section "Windows XP Patch"
        AddSize 2608
        SetOutPath "$INSTDIR"

        !insertmacro FILE_HASH_EQUALS "DINO.exe" "2beb1dc79513258ca45116f5933714e1a109c4da" $0 ; Windows XP Patch checksum
        ${If} $0 == "1"
            MessageBox MB_ICONEXCLAMATION "Binary is already the Windows XP Patch version. Skipping."
            DetailPrint " // Skipping Windows XP Patch."
        ${Else}
            !insertmacro FORCE_RENAME "DINO.exe" "DINO.exe.bak"
            !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crysis/DINO%20xp.7z" \
                                    "https://www.mediafire.com/file_premium/6c73u2fjpgpcx1m/DINO_xp.7z/file" \
                                    "DINO xp.7z" "08d0a6c5e8a91fa56cb4a13bd46136cfa45748e3"
            !insertmacro NSIS7Z_EXTRACT "DINO xp.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section "High Quality Videos"
        AddSize 101581
        SetOutPath "$INSTDIR\Movie"

        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crysis/Movie.rar" \
                                "https://www.mediafire.com/file_premium/wnfkb1a5isy4w6b/Movie.rar/file" \
                                "Movie.rar" "c5575da40f1f32b92668c6ba8fc77c85a57c6110"
        !insertmacro 7Z_EXTRACT "Movie.rar" ".\" "AUTO_DELETE"
    SectionEnd

    Section "Classic REbirth DLL"
        AddSize 3474
        SetOutPath "$INSTDIR"

        !insertmacro FORCE_RENAME "ddraw.dll" "ddraw.dll.bak"
        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crysis/dc1cr-1.0.0-2020-04-24.7z" \
                                "https://www.mediafire.com/file_premium/zdq1avo7p1oahk0/dc1cr-1.0.0-2020-04-24.7z/file" \
                                "dc1cr-1.0.0-2020-04-24.7z" "3a0a62df64fd96807f9ac90cc2485319fbe145d9"
        !insertmacro NSIS7Z_EXTRACT "dc1cr-1.0.0-2020-04-24.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "High Quality Voices and Background Music (Dreamcast)"
        AddSize 232448
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crysis/DINO_CRISIS_HQ_(Voice)_and_(Background_Music)_updated.rar" \
                                "https://www.mediafire.com/file_premium/phtu0nbwgxwr7a2/DINO_CRISIS_HQ_%2528Voice%2529_and_%2528Background_Music%2529_updated.rar/file" \
                                "DINO_CRISIS_HQ_(Voice)_and_(Background_Music)_updated.rar" "c772a8f17e898769479a1aad709527750204e20d"
        !insertmacro 7Z_EXTRACT "DINO_CRISIS_HQ_(Voice)_and_(Background_Music)_updated.rar" ".\" "AUTO_DELETE"
        !insertmacro FORCE_RENAME "Readme.txt" "Readme_HQ_Voice_and_BGM.txt"
    SectionEnd

    Section /o "High Quality Textures (Dreamcast upscaled)"
        AddSize 2527068
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_RANGE_1 "https://cdn2.mulderload.eu/g/dino-crysis/HD_Mod_1.0%20[Repack-MLD].7z.001" "HD_Mod_1.0 [Repack-MLD].7z.001" "149abbde37507d63bef0ad0a673946f756fe599a" 5
        !insertmacro NSIS7Z_EXTRACT "HD_Mod_1.0 [Repack-MLD].7z.001" ".\" ""
        !insertmacro DELETE_RANGE "HD_Mod_1.0 [Repack-MLD].7z.001" 5
        !insertmacro FORCE_RENAME "readme.txt" "Readme_HQ_Textures.txt"
    SectionEnd

    Section
        !insertmacro 7Z_REMOVE
    SectionEnd

    Section
        IfFileExists "$INSTDIR\..\4249130_Launcher.ini" 0 +2
            WriteINIStr "$INSTDIR\..\4249130_Launcher.ini" "Language" "LanguageSetting" "japanese"
    SectionEnd

SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "DINO.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\4249130_DinoCrisis\japanese"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
