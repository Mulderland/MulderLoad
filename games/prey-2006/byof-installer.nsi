!define MUI_WELCOMEPAGE_TEXT "\
WARNING: For legal reasons, this installer doesn't include or distribute the original game files. You must provide your own DVD image. It has been tested with Europe and US releases; compatibility with other versions is not guaranteed.$\r$\n\
$\r$\n\
It will installs the game (without running Installshield), apply the official update v1.4, and adds several enhancements:$\r$\n\
- configure 16/9 and 21/9 resolutions$\r$\n\
- install widescreen HUD fix (by hexaae)$\r$\n\
- install 21/9 support (by fgsfds)$\r$\n\
- apply ultra-high quality settings$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}."

!include "..\..\includes\templates\ByofTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\I6Comp.nsh"

; ...........................................................Europe (Original)............................Europe (Alt)..................Europe (Sold Out Software Rerelease)........USA (Limited Collector's Edition)
!insertmacro BYOF_DEFINE "DVD" "Images files|*.iso" "6d8d476e4d564fd281d7020bc4dcdca4baebef40,c3145876767ab39e610aac5a003d12560e65e62b,33e4f4f41d817baf7cfd1700ebfd4fc3d5dbdc72,afbbac928a852c90a64ad4296358b644a39dfcfa"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Name "Prey 2006"
InstallDir "C:\MulderLoad\Prey 2006"

SectionGroup "Prey 2006 (Full installation)"
    Section
        AddSize 1646265

        # Extract ISO
        !insertmacro 7Z_GET
        !insertmacro 7Z_IMAGE_EXTRACT "$byofPath_DVD" "$INSTDIR\@mulderload\iso" ""

        # Copy files
        RMDir /r "$INSTDIR\@mulderload\iso\Setup\Data\pb" ; We don't need pb folder
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\iso\Setup\Data" "$INSTDIR\"
        RMDir /r "$INSTDIR\@mulderload\iso"

        # Copy key
        FileOpen $0 "$INSTDIR\base\preykey" w
        FileWrite $0 'D23BDPBABCRPTABP$\r$\n'
        FileClose $0
    SectionEnd

    Section "Official Update v1.4"
        SetOutPath "$INSTDIR\@mulderload\update"
        AddSize 40960

        !insertmacro DOWNLOAD_3 "https://community.pcgamingwiki.com/files/file/1063-prey-patches/#4142" \
                                "https://cdn2.mulderload.eu/g/prey-2006/prey_14.zip" \
                                "https://www.mediafire.com/file_premium/4mbewp42mr6pjfd/prey_14.zip/file" \
                                "prey_14.zip" "1a289de4a563e3c815d13658c7ab46108a9eca1e"

        !insertmacro NSISUNZ_EXTRACT "prey_14.zip" ".\" "AUTO_DELETE"

        # Extract Patch Files
        ExecWait '"SetupPreyPt1.4.exe" /s /extract_all:."' $0
        Delete "SetupPreyPt1.4.exe"

        # Extract Patch Files
        !insertmacro I6COMP_GET
        !insertmacro I6COMP_UNPACK "$INSTDIR\@mulderload\update\Disk1\data1.cab" "$INSTDIR\@mulderload\update\unpacked"
        CopyFiles "$INSTDIR\@mulderload\update\unpacked\PREY*.exe" "$INSTDIR\"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\update\unpacked\base" "$INSTDIR\base"

        # Delete temporary folder
        SetOutPath "$INSTDIR"
        RMDir /r "$INSTDIR\@mulderload\update"
    SectionEnd
SectionGroupEnd

!define NSI_INCLUDE
!include "enhancement-pack.nsi"

Function .onInit
    StrCpy $1 ${lang_en} ; Radio Button
    StrCpy $2 ${res_1920_1080} ; Radio Button
FunctionEnd
