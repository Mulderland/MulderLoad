!include "..\..\includes\functions\FileStrReplace.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

!macro ASSERT_FILES_EQUALS EXPECTED_FILE RESULT_FILE
    IntOp $NB_TESTS $NB_TESTS + 1

    NScurl::sha1 -file "${RESULT_FILE}"
    Pop $0
    NScurl::sha1 -file "${EXPECTED_FILE}"
    Pop $1

    ${If} $0 == $1
        DetailPrint "OK ($0 == $1)"
    ${Else}
        IntOp $NB_ERRORS $NB_ERRORS + 1
        DetailPrint "FAILED ($0 != $1)"
    ${EndIf}
!macroend

Section "FileStrReplace"
    DetailPrint " // FileStrReplace 1"
    CopyFiles "..\..\tests\functions\_FileStrReplaceTest\original.conf" "$INSTDIR\result1.conf"
    !insertmacro FILE_STR_REPLACE "FPSLimit      = 0" "FPSLimit      = 60" "1" "1" "$INSTDIR\result1.conf"
    !insertmacro ASSERT_FILES_EQUALS "..\..\tests\functions\_FileStrReplaceTest\expected1.conf" "$INSTDIR\result1.conf"

    DetailPrint " // FileStrReplace 2"
    CopyFiles "..\..\tests\functions\_FileStrReplaceTest\original.conf" "$INSTDIR\result2.conf"
    !insertmacro FILE_STR_REPLACE "FPSLimit      = 0" "FPSLimit      = 60" "2" "1" "$INSTDIR\result2.conf"
    !insertmacro ASSERT_FILES_EQUALS "..\..\tests\functions\_FileStrReplaceTest\expected2.conf" "$INSTDIR\result2.conf"

    DetailPrint " // FileStrReplace 3"
    CopyFiles "..\..\tests\functions\_FileStrReplaceTest\original.conf" "$INSTDIR\result3.conf"
    !insertmacro FILE_STR_REPLACE "FPSLimit      = 0" "FPSLimit      = 60" "3" "1" "$INSTDIR\result3.conf"
    !insertmacro ASSERT_FILES_EQUALS "..\..\tests\functions\_FileStrReplaceTest\expected3.conf" "$INSTDIR\result3.conf"

    DetailPrint " // FileStrReplace 4"
    CopyFiles "..\..\tests\functions\_FileStrReplaceTest\original.conf" "$INSTDIR\result4.conf"
    !insertmacro FILE_STR_REPLACE "FPSLimit      = 0" "FPSLimit      = 60" "1" "2" "$INSTDIR\result4.conf"
    !insertmacro ASSERT_FILES_EQUALS "..\..\tests\functions\_FileStrReplaceTest\expected4.conf" "$INSTDIR\result4.conf"

    DetailPrint " // FileStrReplace 5"
    CopyFiles "..\..\tests\functions\_FileStrReplaceTest\original.conf" "$INSTDIR\result5.conf"
    !insertmacro FILE_STR_REPLACE "FPSLimit      = 0" "FPSLimit      = 60" "2" "2" "$INSTDIR\result5.conf"
    !insertmacro ASSERT_FILES_EQUALS "..\..\tests\functions\_FileStrReplaceTest\expected5.conf" "$INSTDIR\result5.conf"

    DetailPrint " // FileStrReplace 6"
    CopyFiles "..\..\tests\functions\_FileStrReplaceTest\original.conf" "$INSTDIR\result6.conf"
    !insertmacro FILE_STR_REPLACE "FPSLimit      = 0" "FPSLimit      = 60" "3" "1" "$INSTDIR\result6.conf"
    !insertmacro FILE_STR_REPLACE "FPSLimit      = 0" "FPSLimit      = 60" "1" "1" "$INSTDIR\result6.conf"
    !insertmacro ASSERT_FILES_EQUALS "..\..\tests\functions\_FileStrReplaceTest\expected6.conf" "$INSTDIR\result6.conf"

    DetailPrint " // FileStrReplace 7"
    CopyFiles "..\..\tests\functions\_FileStrReplaceTest\original.conf" "$INSTDIR\result7.conf"
    !insertmacro FILE_STR_REPLACE "FPSLimit      = 0" "FPSLimit      = 60" "1" "all" "$INSTDIR\result7.conf"
    !insertmacro ASSERT_FILES_EQUALS "..\..\tests\functions\_FileStrReplaceTest\expected7.conf" "$INSTDIR\result7.conf"
SectionEnd

