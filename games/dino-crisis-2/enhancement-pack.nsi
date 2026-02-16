!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Dino Crisis 2. It includes:$\r$\n\
- Windows XP Patch$\r$\n\
- Classic REbirth$\r$\n\
- (optionaly) High Quality Videos$\r$\n\
- (optionaly) High Quality SFX$\r$\n\
- Corrupted / Missing files fix$\r$\n\
$\r$\n\
WARNING: make sure you select the Japanese Dino2.exe when asked (if using GOG, download the Japanese version)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the Classic REbirth team!"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Dino Crisis 2 [Enhancement Pack]"

Section
    DetailPrint " // Checking that binary is supported"
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Dino2.exe" "f12d9038f903073c0ed54465a9f5c60fd5aba67b" $0 ; Windows XP Patch checksum
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Dino2.exe" "cce6aafe69***d5d678da28" $1 ; Steam Japanese checksum
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Dino2.exe" "2c2903acafd97252226df6f4a245d206310b17cb" $2 ; GOG Japanese checksum
    ${If} $0 != "1"
    ${AndIf} $1 != "1"
    ${AndIf} $2 != "1"
        MessageBox MB_ICONEXCLAMATION "Only GOG Japanese release, or the Steam Japanese executable can apply this patch.$\r$\n\
        $\r$\n\
        If you're using GOG, make sure you downloaded the Japanese version of the game.$\r$\n\
        If you're using Steam, make sure you selected the Dino2.exe from the $\"japanese$\" folder."
        Quit
    ${EndIf}
SectionEnd

SectionGroup /e "Classic REbirth"
    Section "Windows XP Patch"
        AddSize 1176
        SetOutPath "$INSTDIR"

        !insertmacro FILE_HASH_EQUALS "Dino2.exe" "f12d9038f903073c0ed54465a9f5c60fd5aba67b" $0 ; Windows XP Patch checksum
        ${If} $0 == "1"
            MessageBox MB_ICONEXCLAMATION "Binary is already the Windows XP Patch version. Skipping."
            DetailPrint " // Skipping Windows XP Patch."
        ${Else}
            !insertmacro FORCE_RENAME "Dino2.exe" "Dino2.exe.bak"
            !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis-2/Dino2-xp.7z" \
                                    "https://www.mediafire.com/file_premium/fjni41t9im4kqli/Dino2-xp.7z/file" \
                                    "Dino2-xp.7z" "47107fbdaaec9ad62114e071c478545beac97b7f"
            !insertmacro NSIS7Z_EXTRACT "Dino2-xp.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section "Classic REbirth DLL"
        AddSize 3545
        SetOutPath "$INSTDIR"

        !insertmacro FORCE_RENAME "ddraw.dll" "ddraw.dll.bak"
        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis-2/dc2cr-2024-05-05.7z" \
                                "https://www.mediafire.com/file_premium/69dozi4wa1dfwlm/dc2cr-2024-05-05.7z/file" \
                                "dc2cr-2024-05-05.7z" "2d84b2e9b3ebac15ede3fd4beee8bb5a5eaf90e0"
        !insertmacro NSIS7Z_EXTRACT "dc2cr-2024-05-05.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "High Quality Movies"
        AddSize 293888
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis-2/dc2cr_hq_movie_2024-04-29.7z" \
                                "https://www.mediafire.com/file_premium/5gbygmau33k9bfe/dc2cr_hq_movie_2024-04-29.7z/file" \
                                "dc2cr_hq_movie_2024-04-29.7z" "2a8720c19ced0d6f40f598475bfc188aef038edc"
        !insertmacro NSIS7Z_EXTRACT "dc2cr_hq_movie_2024-04-29.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "High Quality SFX"
        AddSize 13619
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis-2/dc2cr_hq_sfx_2024-04-29.7z" \
                                "https://www.mediafire.com/file_premium/dla43867fkmlq31/dc2cr_hq_sfx_2024-04-29.7z/file" \
                                "dc2cr_hq_sfx_2024-04-29.7z" "87693f542928bffb4614e647f9856e7ef11f8085"
        !insertmacro NSIS7Z_EXTRACT "dc2cr_hq_sfx_2024-04-29.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section
        IfFileExists "$INSTDIR\..\4249140_Launcher.ini" 0 +2
            WriteINIStr "$INSTDIR\..\4249140_Launcher.ini" "Language" "LanguageSetting" "japanese"

        !insertmacro FORCE_RENAME "dinput.dll" "dinput.dll.bak"
    SectionEnd
SectionGroupEnd

Section "Fix GOG/Steam corrupted files with Retail files"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis-2/Data%20Retail%20[MLD].7z" \
                            "https://www.mediafire.com/file_premium/kp9hfi5ezdtrvrm/Data_Retail_%255BMLD%255D.7z/file" \
                            "Data Retail [MLD].7z" "a19474b1846eed0fe9564bb6516740ba6b26d268"
    !insertmacro NSIS7Z_EXTRACT "Data Retail [MLD].7z" ".\" "AUTO_DELETE"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Dino2.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\4249140_DinoCrisis2\japanese"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
