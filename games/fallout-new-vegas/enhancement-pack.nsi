!define MUI_WELCOMEPAGE_TEXT "This installer applies community-made performance fixes, bug fixes, and visual improvements while preserving the original, VANILLA EXPERIENCE.$\r$\n$\r$\nIf you're looking for a heavily modded or alternative experience, this package is not intended for that.$\r$\n$\r$\nIncluded Performance && Bug Fixes:$\r$\n- 4GB Patch (by RoyBatterian), YUP (by Yukichigai)$\r$\n- DXVK || NVHR (by iranrmrf)$\r$\n- NVSE + NVTF (by carxt)$\r$\n$\r$\nGraphical Enhancements:$\r$\n- Improved Lighting Shaders (by emoose)$\r$\n- NVTUP Texture Upscale Project (by WestAard)$\r$\n- MulderConfig for widescreen/ultrawide and some options."
!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\templates\select_exe.nsh"

Name "Fallout: New Vegas [Enhancement Pack]"

Var /GLOBAL YUP_Language
Var /GLOBAL YUP_Edition
Var /GLOBAL YUP_URL

SectionGroup /e "Non-NVSE"
    Section "FNV 4GB Patcher v1.5"
        AddSize 225
        SetOutPath $INSTDIR

        !insertmacro Download https://cdn2.mulderload.eu/g/fallout-new-vegas/FNV%204GB%20Patcher%20v1.5/4GB%20Patcher-62552-1-5-1618787921.7z "4GB_Patcher.7z"
        Nsis7z::ExtractWithDetails "4GB_Patcher.7z" "Extracting package %s..."
        Delete "4GB_Patcher.7z"

        ExecWait 'FNVpatch.exe' $0
        Delete "FNVpatch.exe"
    SectionEnd

    Section "DXVK v2.7.1"
        AddSize 4389
        SetOutPath $INSTDIR\@dxvk_tmp
        !insertmacro Download https://github.com/doitsujin/dxvk/releases/download/v2.7.1/dxvk-2.7.1.tar.gz "dxvk.tar.gz"
        !insertmacro Get7z
        nsExec::ExecToLog '".\7z.exe" x -aoa dxvk.tar.gz'
        nsExec::ExecToLog '".\7z.exe" x -aoa dxvk.tar dxvk-2.7.1/x32/d3d9.dll'

        SetOutPath $INSTDIR
        Rename "$INSTDIR\@dxvk_tmp\dxvk-2.7.1\x32\d3d9.dll" "d3d9.dll"
        RMDir /r "$INSTDIR\@dxvk_tmp"
    SectionEnd

    Section "NVHR (New Vegas Heap Replacer) v4.2"
        AddSize 3963
        SetOutPath $INSTDIR

        !insertmacro Download https://cdn2.mulderload.eu/g/fallout-new-vegas/New%20Vegas%20Heap%20Replacer%20v4.2/NVHR-69779-4-2-1665589730.7z "NVHR.7z"
        Nsis7z::ExtractWithDetails "NVHR.7z" "Extracting package %s..."
        Delete "NVHR.7z"
    SectionEnd

    Section "YUP (Yukichigai Unofficial Patch) v13.6"
        AddSize 138240

        # Detect Game Language
        NScurl::sha1 "$INSTDIR\Data\Video\FNVIntro.bik"
        Pop $0
        ${If} $0 == "9134209ea4e3633f4eb5c538309765229a8d8532"
            StrCpy $YUP_Language "en"
        ${ElseIf} $0 == "b9b454601aa06c12496df34a0b50ae1d5d8d8363"
            StrCpy $YUP_Language "fr"
        ${ElseIf} $0 == "1fb007769e64655ca8f84935c0fba3208c520325"
            StrCpy $YUP_Language "it"
        ${ElseIf} $0 == "f9716765ca20b3769a91b55d26b2ba02d4194d87"
            StrCpy $YUP_Language "de"
        ${ElseIf} $0 == "62f4fa2bc7"
            StrCpy $YUP_Language "es"
        ${Else}
            MessageBox MB_OK "YUP installation skipped, game language must be en/fr/it/de/es."
            Goto end_yup
        ${EndIf}

        # Detect Game DLCs
        StrCpy $YUP_Edition "individual"
        IfFileExists "$INSTDIR\Data\DeadMoney - Sounds.bsa" 0 end_yup_detection
            IfFileExists "$INSTDIR\Data\HonestHearts - Sounds.bsa" 0 end_yup_detection
                IfFileExists "$INSTDIR\Data\OldWorldBlues - Sounds.bsa" 0 end_yup_detection
                    IfFileExists "$INSTDIR\Data\LonesomeRoad - Sounds.bsa" 0 end_yup_detection
                        IfFileExists "$INSTDIR\Data\GunRunnersArsenal - Sounds.bsa" 0 end_yup_detection
                            StrCpy $YUP_Edition "complete"
        end_yup_detection:

        DetailPrint " // YUP selected distribution: $YUP_Language - $YUP_Edition"

        # Determine YUP Download URL
        ${If} $YUP_Language == "en"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20-%20Base%20Game%20and%20All%20DLC-51664-13-6-1766868693.7z"
            ${Else}
                StrCpy $YUP_URL "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20-%20Individual%20ESMs-51664-13-6-1766868845.7z"
            ${EndIf}
        ${ElseIf} $YUP_Language == "fr"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20FRA%20-%20Jeu%20de%20base%20et%20Tous%20les%20DLC-51664-13-6-1766958972.7z"
            ${Else}
                StrCpy $YUP_URL "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20FRA%20-%20ESM%20individuels-51664-13-6-1766959242.7z"
            ${EndIf}
        ${ElseIf} $YUP_Language == "it"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20ITA%20-%20Gioco%20base%20e%20Tutti%20i%20DLC-51664-13-6-1766959019.7z"
            ${Else}
                StrCpy $YUP_URL "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20ITA%20-%20Singoli%20ESM-51664-13-6-1766959292.7z"
            ${EndIf}
        ${ElseIf} $YUP_Language == "de"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20DEU%20-%20Basisspiel%20und%20Alle%20DLCs-51664-13-6-1766958874.7z"
            ${Else}
                StrCpy $YUP_URL "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20DEU%20-%20Individuelle%20ESMs-51664-13-6-1766959150.7z"
            ${EndIf}
        ${ElseIf} $YUP_Language == "es"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20ESP%20-%20Juego%20Original%20y%20Todos%20Los%20DLCs-51664-13-6-1766958925.7z"
            ${Else}
                StrCpy $YUP_URL "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20ESP%20-%20ESM%20individuales-51664-13-6-1766959189.7z"
            ${EndIf}
        ${EndIf}

        # Install YUP
        SetOutPath $INSTDIR
        !insertmacro Download $YUP_URL "YUP.7z"
        Nsis7z::ExtractWithDetails "YUP.7z" "Extracting package %s..."
        Delete "YUP.7z"

        end_yup:
    SectionEnd
SectionGroupEnd

SectionGroup /e "NVSE v6.4.4"
    Section
        AddSize 33178
        SetOutPath $INSTDIR

        !insertmacro Download https://github.com/xNVSE/NVSE/releases/download/6.4.4/nvse_6_4_4.7z "NVSE.7z"
        Nsis7z::ExtractWithDetails "NVSE.7z" "Extracting package %s..."
        Delete "NVSE.7z"

        # Create Plugins directory
        SetOutPath $INSTDIR\Data\NVSE\Plugins
    SectionEnd

    Section "NVTF (New Vegas Tick Fix) v10.61"
        AddSize 1352
        SetOutPath $INSTDIR\Data

        !insertmacro Download https://cdn2.mulderload.eu/g/fallout-new-vegas/NVTF%20v10.61/NVTF-66537-10-61-1756195258.7z "NVTF.7z"
        Nsis7z::ExtractWithDetails "NVTF.7z" "Extracting package %s..."
        Delete "NVTF.7z"

        !insertmacro Download https://cdn2.mulderload.eu/g/fallout-new-vegas/NVTF%20v10.61/NVTF%20-%20INI-66537-1-06-1751295478.7z "NVTF-INI.7z"
        Nsis7z::ExtractWithDetails "NVTF-INI.7z" "Extracting package %s..."
        Delete "NVTF-INI.7z"
    SectionEnd

    Section "Improved Lighting Shaders v1.6a"
        AddSize 21709
        SetOutPath $INSTDIR\Data

        !insertmacro Download https://cdn2.mulderload.eu/g/fallout-new-vegas/Improved%20Lightning%20Shaders%20v1.6a/Improved%20Lighting%20Shaders-69833-1-6a-1738800319.zip "Improved_Lighting_Shaders.zip"
        nsisunz::Unzip "Improved_Lighting_Shaders.zip" ".\"
        Delete "Improved_Lighting_Shaders.zip"
    SectionEnd
SectionGroupEnd

Section /o "NVTUP (FNV Texture Upscale Project) v2.0"
    AddSize 28626125
    SetOutPath $INSTDIR\Data

    !insertmacro DownloadRange https://cdn2.mulderload.eu/g/fallout-new-vegas/NVTUP%20v2.0/FNV%20Texture%20Upscale%20Project%20(NVTUP)%202.0-93775-2-0-1765930818.7z "NVTUP.7z" 16
    Nsis7z::ExtractWithDetails "NVTUP.7z.001" "Extracting package %s..."
    !insertmacro DeleteRange "NVTUP.7z" 16
SectionEnd

SectionGroup /e "MulderConfig (latest)"
    Section
        SectionIn RO
        AddSize 1024
        SetOutPath $INSTDIR
        !insertmacro Download https://github.com/mulderload/MulderConfig/releases/latest/download/MulderConfig.exe "MulderConfig.exe"
        !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/fallout-new-vegas/MulderConfig.json "MulderConfig.json"
        !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/fallout-new-vegas/MulderConfig.save.json "MulderConfig.save.json"
        ExecWait '"$INSTDIR\MulderConfig.exe" -apply' $0
    SectionEnd

    Section /o "Microsoft .NET Desktop Runtime 8.0.22 (x64)"
        SetOutPath $INSTDIR
        AddSize 100000

        !insertmacro Download https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/8.0.22/windowsdesktop-runtime-8.0.22-win-x64.exe "windowsdesktop-runtime-win-x64.exe"
        ExecWait '"windowsdesktop-runtime-win-x64.exe" /Q' $0
        Delete "windowsdesktop-runtime-win-x64.exe"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "FalloutNV.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Fallout New Vegas"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
