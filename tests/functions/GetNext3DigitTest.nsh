!include "..\..\includes\functions\GetNext3Digit.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

Section "GetNext3Digit"
    DetailPrint " // GetNext3Digit 1"
    !insertmacro GET_NEXT_3DIGIT "001" $0
    !insertmacro ASSERT_EQUALS $0 "002"

    DetailPrint " // GetNext3Digit 2"
    !insertmacro GET_NEXT_3DIGIT "008" $0
    !insertmacro ASSERT_EQUALS $0 "009"

    DetailPrint " // GetNext3Digit 3"
    !insertmacro GET_NEXT_3DIGIT "009" $0
    !insertmacro ASSERT_EQUALS $0 "010"

    DetailPrint " // GetNext3Digit 4"
    !insertmacro GET_NEXT_3DIGIT "010" $0
    !insertmacro ASSERT_EQUALS $0 "011"

    DetailPrint " // GetNext3Digit 5"
    !insertmacro GET_NEXT_3DIGIT "099" $0
    !insertmacro ASSERT_EQUALS $0 "100"

    DetailPrint " // GetNext3Digit 6"
    !insertmacro GET_NEXT_3DIGIT "998" $0
    !insertmacro ASSERT_EQUALS $0 "999"
SectionEnd
