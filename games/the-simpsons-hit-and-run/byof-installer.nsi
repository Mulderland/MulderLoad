!define MUI_WELCOMEPAGE_TEXT "\
WARNING: For legal reasons, this installer doesn't include or distribute the original game files. You must provide your own disc images. It has been tested with USA, EU, FR and DE releases; compatibility with other versions is not guaranteed.$\r$\n\
$\r$\n\
It installs the game (without running Installshield), removes the legacy disk check, and adds some enhancements:$\r$\n\
- Lucas' Launcher (recommended)$\r$\n\
- d3d8to9 (alternative)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}$\r$\n\
$\r$\n\
Special thanks to the Donut Team! The Simpsons is a trademark of Disney. This project is not affiliated with or endorsed by Disney or any of the original developers."

!include "..\..\includes\templates\ByofTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\I6Comp.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "The Simpsons: Hit & Run"
InstallDir "C:\MulderLoad\The Simpsons Hit & Run"

; ...............................................................Europe (Original)................Europe (Rerelease, Bestseller)..................France (Original).....................Germany (Original).........................USA (Original).........................Germany (Rerelease)..............
!insertmacro BYOF_DEFINE "CD1" "Image files|*.bin;*.iso" "cd51dc48f2de055f4760735f48dbce743003db94,a32bd148a4b916ab2ff289f7d3e23a8b47476b20,511b03266d3e69a8112b7a0e13a00cc25565f060,9c3a399cbf2514fbe7b8c4979324a10dc6cded33,17b4fee16ed849e4a5894496af6d39ba5f9439f4,cae0716b09ea3e77b68b7c78e479ddd1d485de60"
!insertmacro BYOF_DEFINE "CD2" "Image files|*.bin;*.iso" "d86506d3232f83a652a83ffb23b1577b1f0a563d,a10bfcdbe1c372b7db61e6b7485eb0b73af207c2,68e7a1fda5b292d34e67bb54e898cdd685e5c2d8,e14f10c5e55ae810927006b736d71e14b8a565f7,449e621d2aeb335c87fba1e07f04233aecb19040"
!insertmacro BYOF_DEFINE "CD3" "Image files|*.bin;*.iso" "25da0270eafcc8b3923fe8da79c6bf430e33cbea,81c5b4bf2e355eaf767d97d13282b75a67092ceb,de901086f7fdc0def20f880b8b7289ab9857db7e,e2867ab3ad5bd6ef52c630a87228c1ebbdb3a3d4,0939c3db74387e55487a8c77afea04211157dce4"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

!define EXE_HASH_EUROPE "17b7cdc2eb46a762ef649fa3b9240f6e71f4488c"
!define EXE_HASH_FRANCE "78bf51ba9043d6b6796d87c3cff7f783edb4f78f"
!define EXE_HASH_GERMANY "541599db1df57baca4df261cb5a7aa5e1ae0f33a"
!define EXE_HASH_SPAIN "c3869ad5420cb0ec77f4768a666ff05a089ba67b"
!define EXE_HASH_USA "08fe7848f79c54c77cdc9bc2aa3d6eedb4c7aa40"

!macro MOVE_P3D_Files PATH
    CreateDirectory `$INSTDIR\art\${PATH}`
    CopyFiles "$INSTDIR\${PATH}\*.p3d" "$INSTDIR\art\${PATH}"
    Delete "$INSTDIR\${PATH}\*.p3d"
!macroend

SectionGroup "The Simpsons: Hit & Run (Full Installation)"
    Section
        AddSize 1929380
        SetOutPath "$INSTDIR\@mulderload\iso"

        !insertmacro 7Z_GET
        !insertmacro 7Z_IMAGE_EXTRACT "$byofPath_CD1" "$INSTDIR\@mulderload\iso" ""
        !insertmacro 7Z_IMAGE_EXTRACT "$byofPath_CD2" "$INSTDIR\@mulderload\iso" ""
        !insertmacro 7Z_IMAGE_EXTRACT "$byofPath_CD3" "$INSTDIR\@mulderload\iso" ""
        !insertmacro 7Z_REMOVE

        !insertmacro I6COMP_GET
        !insertmacro I6COMP_UNPACK "$INSTDIR\@mulderload\iso\data1.cab" "$INSTDIR"
        !insertmacro I6COMP_REMOVE

        SetOutPath "$INSTDIR"

        # Move files to proper locations
        DetailPrint " // Fixing files hierarchy"
        CreateDirectory "$INSTDIR\art"
        CreateDirectory "$INSTDIR\scripts"

        ## cars (mixed in art/ and scripts/)
        CreateDirectory "$INSTDIR\art\cars"
        !insertmacro MOVE_P3D_Files cars
        Rename "$INSTDIR\cars" "$INSTDIR\scripts\cars"

        ## missions (mixed in art/ and scripts/)
        CreateDirectory "$INSTDIR\art\missions"
        Rename "$INSTDIR\missions\generic" "$INSTDIR\art\missions\generic"
        Rename "$INSTDIR\missions\h2h" "$INSTDIR\art\missions\h2h"
        !insertmacro MOVE_P3D_Files missions\level01
        !insertmacro MOVE_P3D_Files missions\level02
        !insertmacro MOVE_P3D_Files missions\level03
        !insertmacro MOVE_P3D_Files missions\level04
        !insertmacro MOVE_P3D_Files missions\level05
        !insertmacro MOVE_P3D_Files missions\level06
        !insertmacro MOVE_P3D_Files missions\level07
        !insertmacro MOVE_P3D_Files missions\level08
        Rename "$INSTDIR\missions" "$INSTDIR\scripts\missions"

        ## files in root
        CopyFiles "$INSTDIR\*.p3d" "$INSTDIR\art"
        Delete "$INSTDIR\*.p3d"
        CopyFiles "$INSTDIR\*.mfk" "$INSTDIR\scripts"
        Delete "$INSTDIR\*.mfk"

        ## other directories
        Rename "$INSTDIR\atc" "$INSTDIR\art\atc"
        Rename "$INSTDIR\chars" "$INSTDIR\art\chars"
        Rename "$INSTDIR\frontend" "$INSTDIR\art\frontend"
        Rename "$INSTDIR\nis" "$INSTDIR\art\nis"
        CreateDirectory "$INSTDIR\scripts\missions\level09" # empty dir, created by real installshield

        # Copy missing files from images
        DetailPrint " // Get missing files from images"

        IfFileExists "$INSTDIR\@mulderload\iso\dialog.rcf" 0 +2
            Rename "$INSTDIR\@mulderload\iso\dialog.rcf" "$INSTDIR\dialog.rcf"

        IfFileExists "$INSTDIR\@mulderload\iso\dialogf.rcf" 0 +2
            Rename "$INSTDIR\@mulderload\iso\dialogf.rcf" "$INSTDIR\dialogf.rcf"

        IfFileExists "$INSTDIR\@mulderload\iso\dialogg.rcf" 0 +2
            Rename "$INSTDIR\@mulderload\iso\dialogg.rcf" "$INSTDIR\dialogg.rcf"

        IfFileExists "$INSTDIR\@mulderload\iso\dialogs.rcf" 0 +2
            Rename "$INSTDIR\@mulderload\iso\dialogs.rcf" "$INSTDIR\dialogs.rcf"

        Rename "$INSTDIR\@mulderload\iso\movies" "$INSTDIR\movies"

        # Delete unnecessary files
        DetailPrint " // Delete unnecessary files"
        Delete "_IsRes.dll"
        Delete "BDA.CAB"
        Delete "BDANT.CAB"
        Delete "CFGMGR32.DLL"
        Delete "corecomp.ini"
        Delete "ctor.dll"
        Delete "default.pal"
        Delete "DIRECTX.CAB"
        Delete "DotNetInstaller.exe"
        Delete "DSETUP.DLL"
        Delete "DSETUP32.DLL"
        Delete "DXNT.CAB"
        Delete "DXSETUP.EXE"
        Delete "IGDI.dll"
        Delete "iKernel.dll"
        Delete "iscript.dll"
        Delete "IsProBE.tlb"
        Delete "isrt.dll"
        Delete "iuser.dll"
        Delete "license.txt"
        Delete "MinReqts.txt"
        Delete "objectps.dll"
        Delete "Setup.dll"
        Delete "setup.inx"
        Delete "SETUPAPI.DLL"
        Delete "StringTable-*.ips"
        Delete "vssver.scc"

        # Delete temporary files
        DetailPrint " // Delete temporary files"
        RMDir /r "$INSTDIR\@mulderload\iso"
    SectionEnd

    Section "Remove legacy disc check"
        AddSize 3482
        SetOutPath "$INSTDIR"

        NScurl::sha1 "$INSTDIR\Simpsons.exe"
        Pop $9
        ${If} $9 == ${EXE_HASH_EUROPE}
            DetailPrint " // Apply english diff on European version"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/the-simpsons-hit-and-run/Europe%20(Both)/Simpsons.exe.xdelta" "$INSTDIR\Simpsons.exe.xdelta" "a07ccd46911000d5700577d1dfda6b69383c3cbd"
        ${ElseIf} $9 == ${EXE_HASH_FRANCE}
            DetailPrint " // Apply french diff on France version"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/the-simpsons-hit-and-run/France%20(Original)/Simpsons.exe.xdelta" "$INSTDIR\Simpsons.exe.xdelta" "a77f6a73f772597af678dd4ca4c51c2d9771313f"
        ${ElseIf} $9 == ${EXE_HASH_GERMANY}
            DetailPrint " // Apply german diff on Germany version"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/the-simpsons-hit-and-run/Germany%20(Rerelease)/Simpsons.exe.xdelta" "$INSTDIR\Simpsons.exe.xdelta" "6b35dd31b0f135ce5507afc68f442227ebd79dcc"
        ${ElseIf} $9 == ${EXE_HASH_SPAIN}
            DetailPrint " // Apply spanish diff on Spain version"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/the-simpsons-hit-and-run/Spain%20(Original)/Simpsons.exe.xdelta" "$INSTDIR\Simpsons.exe.xdelta" "10ddf112d4ee8d0bce9c76c388e0c176511078cc"
        ${ElseIf} $9 == ${EXE_HASH_USA}
            DetailPrint " // Apply english diff on USA version"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/the-simpsons-hit-and-run/USA%20(Original)/Simpsons.exe.xdelta" "$INSTDIR\Simpsons.exe.xdelta" "cb69fed2706d95c8bd0c36970c7a4732e1f1e5e3"
        ${Else}
            MessageBox MB_ICONEXCLAMATION "Unknown version of Simpsons.exe, skipping patch"
            Goto end_diff
        ${EndIf}

        !insertmacro FORCE_COPY "Simpsons.exe" "Simpsons.exe.bak"
        !insertmacro XDELTA3_GET
        !insertmacro XDELTA3_PATCH_FILE "$INSTDIR\Simpsons.exe" "$INSTDIR\Simpsons.exe.xdelta"
        !insertmacro XDELTA3_REMOVE
        end_diff:
    SectionEnd
SectionGroupEnd

SectionGroup /e "Improvements" impr
    Section "Lucas' Launcher v1.26.1 (recommended)" impr_lucas
        AddSize 12083
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://modbakery.donutteam.com/release-branch-version-files/download/6/46/75/71" "LucasLauncher.zip" ""
        !insertmacro NSISUNZ_EXTRACT "LucasLauncher.zip" ".\" "AUTO_DELETE"

        File resources\Settings.ini
    SectionEnd

    Section /o "d3d8to9" impr_d3d8to9
        AddSize 122
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_1 "https://github.com/crosire/d3d8to9/releases/latest/download/d3d8.dll" "d3d8.dll" ""
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $1 ${impr_lucas} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${impr}
        !insertmacro UnSelectSection ${impr}
    ${Else}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${impr_lucas}
            !insertmacro RadioButton ${impr_d3d8to9}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
