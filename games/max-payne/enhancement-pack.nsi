!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Max Payne, aiming to provide a modern vanilla experience. It includes:$\r$\n\
- Crash fix because of corrupted levels (if detected)$\r$\n\
- Crash fix for modern CPUs (JPEG error)$\r$\n\
- Sound fix (with DSOAL)$\r$\n\
- Difficulty fixes$\r$\n\
- Widescreen fix (by ThirteenAG)$\r$\n\
- Upscaled textures (from Max Payne Remastered)$\r$\n\
- New Weapons sounds$\r$\n\
- Translation patches (texts only)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to Gaiver74 for his Max Payne Remastered!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Max Payne [Enhancement Pack]"

Section
    !insertmacro 7Z_GET
SectionEnd

SectionGroup "Bug fixes"
    Section "Fix corrupted levels (if detected)"
        SetOutPath "$INSTDIR"

        DetailPrint " // Comparing level checksum with correct one..."
        !insertmacro FILE_HASH_EQUALS "x_level1.ras" "d7dc20d91930b67c84dad0fb18a5c712bd324330" $0
        ${If} $0 != "1"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/max-payne/fix/Steam Corrupted Levels Fix [MLD].7z" \
                                    "Steam Corrupted Levels Fix [MLD].7z" \
                                    "745253dd796e0833ebba0ff91cd40e83c5f76678"

            !insertmacro NSIS7Z_EXTRACT "Steam Corrupted Levels Fix [MLD].7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section "Fix JPEG errors on modern CPUs"
        AddSize 276
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/max-payne/fix/rlmfc for ryzen.rar" \
                                "rlmfc for ryzen.rar" \
                                "39db990749e5dcbbd6a81b59075ad059998563f3"

        !insertmacro 7Z_EXTRACT "rlmfc for ryzen.rar" ".\" "AUTO_DELETE"
    SectionEnd

    Section "Fix sound (DSOAL v1.31a + 07-02-2022 fix)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/max-payne/fix/DSOAL v1.31a with 07-02-2022 fix [Repack-MLD].7z" \
                                "DSOAL [Repack-MLD].7z" \
                                "b917abedd17f27bcad3d121a8d0208376e2cc055"

        !insertmacro NSIS7Z_EXTRACT "DSOAL [Repack-MLD].7z" ".\" "AUTO_DELETE"

        WriteRegStr HKCU "Software\Classes\WOW6432Node\CLSID\{47D4D946-62E8-11CF-93BC-444553540000}\InprocServer32" "" "dsound.dll"
        WriteRegStr HKCU "Software\Classes\WOW6432Node\CLSID\{3901CC3F-84B5-4FA4-BA35-AA8172B8A09B}\InprocServer32" "" "dsound.dll"
    SectionEnd
SectionGroupEnd

SectionGroup "Difficulty fixes"
    Section "Remove broken Adaptive Difficulty"
        AddSize 9

        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_1 "https://community.pcgamingwiki.com/files/file/2807-max-payne-flat-difficulty-vanilla-pc-values/" \
                                "payne_difficulty.7z" \
                                "d450928893efad20708de6ec8ae1d0678a7499cd"

        !insertmacro NSIS7Z_EXTRACT "payne_difficulty.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section "Unlock all difficulties"
        WriteRegStr HKCU "Software\Remedy Entertainment\Max Payne\Game Level" "" "1"
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne\Game Level" "hell" 1
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne\Game Level" "nightmare" 1
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne\Game Level" "timedmode" 1
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne\Game Level" "normal" 1
    SectionEnd
SectionGroupEnd

SectionGroup /e "Improvements"
    Section "Widescreen Fix (by ThirteenAG)"
        SetOutPath "$INSTDIR"

        # Widescreen Fix
        !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/mp1/MaxPayne.WidescreenFix.zip" \
                                "https://cdn.mulderload.eu/games/max-payne/impr_gfx/MaxPayne.WidescreenFix.zip" \
                                "MaxPayne.WidescreenFix.zip" \
                                "7ba1a581006c3df8140624fee6ba01b858bf72f2"

        !insertmacro NSISUNZ_EXTRACT "MaxPayne.WidescreenFix.zip" ".\" "AUTO_DELETE"
        AddSize 313

        # Ultimate ASI Loader (latest)
        !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/d3d8-Win32.zip" \
                                "d3d8-Win32.zip" \
                                ""

        !insertmacro NSISUNZ_EXTRACT_ONE "d3d8-Win32.zip" ".\" "d3d8.dll" "AUTO_DELETE"
        AddSize 5271

        # Add configuration with D3D9 enabled by default
        File "/oname=scripts\global.ini" "resources\global.ini"
    SectionEnd

    Section /o "Upscaled Textures (from MP Remastered 1.3)"
        # 4GB Patched executable
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/mods/max-payne-4gb-executable-for-steam/downloads/maxpayne" \
                                "_maxpayne_4gb.exe.bak" \
                                "1806d2151e5ea7663dd2fd1754def639"

        AddSize 4836

        # Upscaled textures
        SetOutPath "$INSTDIR\@mulderload\mp_remastered"

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/games/max-payne/addons/max-payne-remastered" \
                                "MPRemastered1.3.zip" \
                                "cf48d7ce2676831d36c0b00bb76c9b57"

        !insertmacro NSISUNZ_EXTRACT "MPRemastered1.3.zip" ".\" "AUTO_DELETE"

        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\mp_remastered\data" "$INSTDIR\data"
        AddSize 1090519

        # Cleanup
        SetOutPath "$INSTDIR"
        RMDir /r "$INSTDIR\@mulderload\mp_remastered"
    SectionEnd

    Section "New Weapons sounds (by TheSorrow55)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/maxpayne/mods/38?tab=files&file_id=88" \
                                "MP-weapons sounds-38-V1-1759949431.rar" \
                                "9f8fd64393b8fbf0136ae32b3ae721a44162d359"

        !insertmacro 7Z_EXTRACT "MP-weapons sounds-38-V1-1759949431.rar" ".\" "AUTO_DELETE"
        !insertmacro FORCE_RENAME "$INSTDIR\MAX PAYNE WEAPONS SOUNDS\x_data.ras" "$INSTDIR\_x_data_weapons.ras.bak"
        RMDir "$INSTDIR\MAX PAYNE WEAPONS SOUNDS"
    SectionEnd
SectionGroupEnd

SectionGroup "Translation patches (texts only)"
    Section /o "French patch"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/max-payne/translation/MP1_TextOnly_fr-FR.ras" \
                                "$INSTDIR\_MP1_TextOnly_fr-FR.ras.bak" \
                                "05e4c31c68a924537818357daea9ee06c50848bf"
        AddSize 69239
    SectionEnd

    Section /o "Italian patch"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/max-payne/translation/MP1_TextOnly_it-IT.ras" \
                                "$INSTDIR\_MP1_TextOnly_it-IT.ras.bak" \
                                "a215ef9e635cc000e77cf83fbbfa3b8b77689fd8"
        AddSize 69287
    SectionEnd

    Section /o "Polish patch"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/max-payne/translation/MP1_TextOnly_pl-PL.ras" \
                                "$INSTDIR\_MP1_TextOnly_pl-PL.ras.bak" \
                                "800b2dcc64bec7519962cfc8c3bf83bf3d027d3c"
        AddSize 69083
    SectionEnd

    Section /o "Portuguese patch (Brazil)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/max-payne/translation/MP1_TextOnly_pt-BR.ras" \
                                "$INSTDIR\_MP1_TextOnly_pt-BR.ras.bak" \
                                "bd1ab683f22d4389a05a63aec41b6957c040cf71"
        AddSize 67453
    SectionEnd

    Section /o "Russian patch"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/max-payne/translation/MP1_TextOnly_ru-RU.ras" \
                                "$INSTDIR\_MP1_TextOnly_ru-RU.ras.bak" \
                                "b05a9186a38444cbe17097a7944af80c7c4f6e74"
        AddSize 72284
    SectionEnd

    Section /o "Spanish patch"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/max-payne/translation/MP1_TextOnly_es-ES.ras" \
                                "$INSTDIR\_MP1_TextOnly_es-ES.ras.bak" \
                                "30573c689a5b00934a7d406351d18e1ff756fe4d"
        AddSize 71145
    SectionEnd
SectionGroupEnd

Section "MulderConfig (latest)"
    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"

    ${IfNot} ${FileExists} "$INSTDIR\_maxpayne.exe.bak"
        CopyFiles "$INSTDIR\maxpayne.exe" "$INSTDIR\_maxpayne.exe.bak" 6148
    ${EndIf}

    ${IfNot} ${FileExists} "$INSTDIR\_x_data.ras.bak"
        CopyFiles "$INSTDIR\x_data.ras" "$INSTDIR\_x_data.ras.bak" 131090
    ${EndIf}
SectionEnd

Section
    !insertmacro 7Z_REMOVE
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "maxpayne.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Max Payne"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
