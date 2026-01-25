!include "..\..\includes\functions\StrContains.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

Section "StrContains"
    DetailPrint " // StrContains 1 (Edge Case) : empty needle [Found]"
    !insertmacro STR_CONTAINS "hello world" "" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrContains 2 (Edge Case) : empty needle = empty haystack [Found]"
    !insertmacro STR_CONTAINS "" "" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrContains 3 (Edge Case) : needle = haystack [Found]"
    !insertmacro STR_CONTAINS "hello world" "hello world" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrContains 4 (Edge Case) : len(needle) > len(haystack) [NotFound]"
    !insertmacro STR_CONTAINS "hello world" "hello world and more" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrContains 5 : needle at the beginning [Found]"
    !insertmacro STR_CONTAINS "hello world" "hello" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrContains 6 : needle in the middle [Found]"
    !insertmacro STR_CONTAINS "the world is yours" "world" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrContains 7 : needle at the end [Found]"
    !insertmacro STR_CONTAINS "hello world" "world" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrContains 8 : needle (wrong case) at the beginning [Found]"
    !insertmacro STR_CONTAINS "hello world" "Hello" $0
    !insertmacro ASSERT_EQUALS $0 1 ; because NSIS string functions are case-insensitive

    DetailPrint " // StrContains 9 : needle (wrong case) in the middle [Found]"
    !insertmacro STR_CONTAINS "the world is yours" "World" $0
    !insertmacro ASSERT_EQUALS $0 1 ; because NSIS string functions are case-insensitive

    DetailPrint " // StrContains 10 : needle (wrong case) at the end [Found]"
    !insertmacro STR_CONTAINS "hello world" "World" $0
    !insertmacro ASSERT_EQUALS $0 1 ; because NSIS string functions are case-insensitive

    DetailPrint " // StrContains 11 : missing needle [NotFound]"
    !insertmacro STR_CONTAINS "hello world" "everybody" $0
    !insertmacro ASSERT_EQUALS $0 0
SectionEnd
