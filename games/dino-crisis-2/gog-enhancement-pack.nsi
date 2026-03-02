!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Dino Crisis 2 (GOG), with:$\r$\n\
- Corrupted / Missing files fix$\r$\n\
- Dino Crisis 2 Classic REbirth (req GOG Japanese version)$\r$\n\
- High Quality Videos$\r$\n\
- High Quality SFX$\r$\n\
- Rex-HD Project Preview (requires GOG English version)$\r$\n\
- MulderConfig$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the Rex-HD project for their new Textures, and of course to the Classic REbirth team!"

!define ON_SELECTED_FILE
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Dino Crisis 2 [GOG Enhancement Pack]"

!define GOG_ENHANCEMENT_PACK_NSI
!include "steam-enhancement-pack.nsi"

Function .onInit
    StrCpy $SELECT_FILENAME "Dino2.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\GOG Galaxy\Games\Dino Crisis 2\Dino2.exe"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd

Function OnSelectedFile
    !insertmacro STACKFRAME_BEGIN 0 2

    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Dino2.exe" "f12d9038f903073c0ed54465a9f5c60fd5aba67b" $R0 ; Windows XP Patch checksum
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Dino2.exe" "2c2903acafd97252226df6f4a245d206310b17cb" $R1 ; GOG Japanese checksum
    ${If} $R0 = "1"
    ${OrIf} $R1 = "1"
        MessageBox MB_ICONINFORMATION "GOG Japanese version detected!$\r$\n- Classic REbirth will be available$\r$\n- Rex-HD Project will be unavailable"
        SectionSetFlags ${rebirth1} ${SF_SELECTED}
        SectionSetFlags ${rebirth2} ${SF_SELECTED}
        SectionSetFlags ${rebirth3} ${SF_SELECTED}
        SectionSetFlags ${rebirth4} ${SF_SELECTED}
        SectionSetFlags ${rexhd} ${SF_RO}
    ${Else}
        !insertmacro FILE_HASH_EQUALS "$INSTDIR\Dino2.exe" "30757dc64f562d9e8284a7836d822d9a20d2f836" $R0 ; GOG English checksum
        ${If} $R0 = "1"
            MessageBox MB_ICONINFORMATION "GOG English version detected!$\r$\n- Classic REbirth will be unavailable$\r$\n- Rex-HD Project will be available"
            SectionSetFlags ${rebirth1} ${SF_RO}
            SectionSetFlags ${rebirth2} ${SF_RO}
            SectionSetFlags ${rebirth3} ${SF_RO}
            SectionSetFlags ${rebirth4} ${SF_RO}
            SectionSetFlags ${rexhd} ${SF_SELECTED}
        ${Else}
            MessageBox MB_ICONEXCLAMATION "Unknown version detected!$\r$\n$\r$\nProceed with caution!$\r$\nYou should not mix REbirth and Rex-HD."
            SectionSetFlags ${rebirth1} 0
            SectionSetFlags ${rebirth2} 0
            SectionSetFlags ${rebirth3} 0
            SectionSetFlags ${rebirth4} 0
            SectionSetFlags ${rexhd} 0
        ${EndIf}
    ${EndIf}

    !insertmacro STACKFRAME_END 0 2
FunctionEnd
