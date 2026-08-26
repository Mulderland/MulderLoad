!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Resident Evil (GOG), with:$\r$\n\
- Resident Evil Classic REbirth$\r$\n\
- Translation patches$\r$\n\
- Resident Evil HD Mod (by TeamX)$\r$\n\
- Seamless HD Project v1.1 (by RESHDP)$\r$\n\
- RE-Enhance v2.0 (by SonicB00M)$\r$\n\
- High Quality FMVs$\r$\n\
- High Quality Audio (by lexas87)$\r$\n\
$\r$\n\
WARNING: make sure you've downloaded the Japanese version of the game on GOG.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}$\r$\n\
$\r$\n\
Special thanks to the Classic REbirth team!"

!define ON_SELECTED_FILE
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Resident Evil [GOG Enhancement Pack]"

!define GOG_ENHANCEMENT_PACK_NSI
!include "steam-enhancement-pack.nsi"

Function .onInit
    StrCpy $9 ${fmv1} ; Radio Button
    StrCpy $SELECT_FILENAME "Biohazard.exe"
    StrCpy $SELECT_INSTALL_PATH "C:\Program Files (x86)\GOG Galaxy\Games\Resident Evil"
FunctionEnd

Function OnSelectedFile
    !insertmacro STACKFRAME_BEGIN 0 4
    DetailPrint " // Checking that binary is supported"
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Biohazard.exe" "08e55bd30cfc31b8d4c62c0fbb8616ecd96f18f3" $R0 ; GOG Japanese checksum
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Biohazard.exe" "047f4feea01b18c69f12e790f2dc837ae0b7107f" $R1 ; Mediakite 1.01 checksum
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Biohazard.exe" "98f335e3a568f4e7bbe2ac3063cd5fcee2145b86" $R2 ; Mediakite 1.01 checksum (4GB Patched)
    ${If} $R0 != "1"
    ${AndIf} $R1 != "1"
    ${AndIf} $R2 != "1"
        MessageBox MB_ICONEXCLAMATION "Only GOG Japanese release can apply this Enhancement Pack.$\r$\n\
        $\r$\n\
        Make sure you downloaded the Japanese version of the game on GOG."
        Strcpy $R3 0
    ${Else}
        Strcpy $R3 1
    ${EndIf}
    !insertmacro STACKFRAME_RETURN 0 4 $R3
    !insertmacro STACKFRAME_END 0 4
FunctionEnd
