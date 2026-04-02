!ifndef BYOF_INSTALLER_NSI
    !define MUI_WELCOMEPAGE_TEXT "\
    This is an Enhancement Pack for Dirt 2. It includes:$\r$\n\
    - Updated installers for OpenAL, GFWL, Rapture3D.$\r$\n\
    - Care Package v1.1 (by thrive4)$\r$\n\
    - FOV Change Software (by dengo)$\r$\n\
    - GFWL Fix (by ThirteenAG)$\r$\n\
    $\r$\n\
    ${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
    $\r$\n\
    Special thanks to thrive4 and ThirteenAG!"

    !define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
    !define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
    !define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\@mulderload\README.txt"
    !define MUI_FINISHPAGE_SHOWREADME_TEXT "Show information about GFWL"
    !include "..\..\includes\templates\SelectTemplate.nsh"
    !include "..\..\includes\tools\7z.nsh"

    Name "Colin McRae: Dirt 2 [Enhancement Pack]"
!endif

!ifdef BYOF_INSTALLER_NSI
    Section ""
!else
    Section "Update redistributables installers"
!endif
    SetOutPath "$INSTDIR\redist\OpenAL"
    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/_redist/oalinst_2.1.zip" \
                            "https://www.mediafire.com/file_premium/lwkut4mwyxkp1e5/oalinst_2.1.zip/file" \
                            "oalinst.zip" "8134406423071689df2245e6440ec73dfd1db74b"
    !insertmacro NSISUNZ_EXTRACT "oalinst.zip" ".\" "AUTO_DELETE"
    !insertmacro FORCE_RENAME "$INSTDIR\redist\OpenAL\OALInst.exe" "$INSTDIR\redist\OpenAL\OpenALwEAX.exe"

    SetOutPath "$INSTDIR\redist\GFWL"
    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/_redist/gfwlivesetup.zip" \
                            "https://www.mediafire.com/file_premium/lqo6o275xnm9y1x/gfwlivesetup.zip/file" \
                            "gfwlivesetup.zip" "917b90c585d871f4d08878786f821b80dbd25eea"
    !insertmacro NSISUNZ_EXTRACT_ONE "gfwlivesetup.zip" ".\" "xliveredist.msi" "AUTO_DELETE"
    Delete "gfwlivesetup.exe"

    SetOutPath "$INSTDIR\redist\Rapture3D"
    !insertmacro DOWNLOAD_3 "https://www.blueripplesound.com/download/public/rapture3dgame_2.7.4_win.exe" \
                            "https://cdn1.mulderload.eu/games/_redist/rapture3dgame_2.7.4_win.exe" \
                            "https://www.mediafire.com/file_premium/492ezqorxfhehdn/rapture3dgame_2.7.4_win.exe/file" \
                            "rapture3dgame_2.7.4_win.exe" "4ab1aaaf7a46f082abad203a07b529a9977f0fa0"
    Delete "rapture3d_2.3.22game.exe"
    Delete "rapture3d_2.3.26game.exe"
SectionEnd

Section "Shaders Upgrade (Care Package v1.1 by thrive4)"
    AddSize 934
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/colin-mcrae-dirt-2/dirt2%20carepackage%20v11-1-1-1-1687352392.zip" \
                            "https://www.mediafire.com/file_premium/vx66w2sy8l31onn/dirt2_carepackage_v11-1-1-1-1687352392.zip/file" \
                            "dirt2 carepackage v11-1-1-1-1687352392.zip" "8d379867e927035cb28470c0eb98d3620fc64101"
    !insertmacro NSISUNZ_EXTRACT "dirt2 carepackage v11-1-1-1-1687352392.zip" ".\" "AUTO_DELETE"
SectionEnd

Section "FOV Change Software (by dengo)"
    AddSize 749
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/c09cg9fn8gpo08t/Dirt3FovChange-v0.2.zip/file" \
                            "https://cdn1.mulderload.eu/games/dirt-3/Dirt3FovChange-v0.2.zip" \
                            "Dirt3FovChange.zip" "7f7ae70c385f5b30cb97b234c467ac294699e16b"
    !insertmacro NSISUNZ_EXTRACT "Dirt3FovChange.zip" ".\" "AUTO_DELETE"
SectionEnd

Section "GFWL Fix (Xliveless by ThirteenAG)"
    AddSize 2321
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/xlive-Win32.zip" "xlive-Win32.zip" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "xlive-Win32.zip" ".\"  "xlive.dll" "AUTO_DELETE"
SectionEnd

SectionGroup /e "MulderConfig"
    !insertmacro MULDERCONFIG_SECTIONS "$INSTDIR" "resources"

    Section "Intro Skip (by Garrett)"
        AddSize 4
        SetOutPath "$INSTDIR\@mulderload\introskip"

        # Download modded videos
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/colin-mcrae-dirt-2/Dirt%202%20No%20Intro.zip" \
                                "https://www.mediafire.com/file_premium/q0yie4bo5ivj6l4/Dirt_2_No_Intro.zip/file" \
                                "Dirt 2 No Intro.zip" "d105ec46efeac59aaccae9f610a2274187717b2d"
        !insertmacro NSISUNZ_EXTRACT "Dirt 2 No Intro.zip" ".\" "AUTO_DELETE"

        # Rename modded videos (to allow switch)
        !insertmacro FORCE_RENAME "video\AMD_sting.bik" "video\_AMD_sting.mod.bak"
        !insertmacro FORCE_RENAME "video\ego_sting.bik" "video\_ego_sting.mod.bak"
        !insertmacro FORCE_RENAME "video\intel_sting.bik" "video\_intel_sting.mod.bak"
        !insertmacro FORCE_RENAME "video\sting.bik" "video\_sting.mod.bak"
        !insertmacro FORCE_RENAME "video\sting_us.bik" "video\_sting_us.mod.bak"

        # Apply
        SetOutPath "$INSTDIR"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\introskip" "$INSTDIR"

        # Backup original videos (to allow switch)
        CopyFiles "$INSTDIR\video\AMD_sting.bik" "$INSTDIR\video\_AMD_sting.ori.bak" 8222
        CopyFiles "$INSTDIR\video\ego_sting.bik" "$INSTDIR\video\_ego_sting.ori.bak" 5276
        CopyFiles "$INSTDIR\video\intel_sting.bik" "$INSTDIR\video\_intel_sting.ori.bak" 5618
        CopyFiles "$INSTDIR\video\sting.bik" "$INSTDIR\video\_sting.ori.bak" 13351
        CopyFiles "$INSTDIR\video\sting_us.bik" "$INSTDIR\video\_sting_us.ori.bak" 13296
    SectionEnd
SectionGroupEnd

Section
    # Copy readme
    SetOutPath "$INSTDIR\@mulderload"
    File "resources\README.txt"
SectionEnd

!ifndef BYOF_INSTALLER_NSI
    Function .onInit
        StrCpy $SELECT_FILENAME "dirt2_game.exe"
        StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Dirt 2"
        StrCpy $SELECT_RELATIVE_INSTDIR ""
        !insertmacro MULDERCONFIG_ONINIT
    FunctionEnd
!endif
