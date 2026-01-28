!include "..\..\includes\functions\StrEndsWith.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

Section "StrEndsWith"
    DetailPrint " // StrEndsWith 1 (Edge Case) : empty needle [Found]"
    !insertmacro STR_ENDS_WITH "hello world" "" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrEndsWith 2 (Edge Case) : empty needle = empty haystack [Found]"
    !insertmacro STR_ENDS_WITH "" "" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrEndsWith 3 (Edge Case) : needle = haystack [Found]"
    !insertmacro STR_ENDS_WITH "hello world" "hello world" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrEndsWith 4 (Edge Case) : len(needle) > len(haystack) [NotFound]"
    !insertmacro STR_ENDS_WITH "hello world" "hello world and more" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrEndsWith 5 : needle at the beginning [NotFound]"
    !insertmacro STR_ENDS_WITH "hello world" "hello" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrEndsWith 6 : needle in the middle [NotFound]"
    !insertmacro STR_ENDS_WITH "the world is yours" "world" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrEndsWith 7 : needle at the end [Found]"
    !insertmacro STR_ENDS_WITH "hello world" "world" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrEndsWith 8 : needle (wrong case) at the beginning [NotFound]"
    !insertmacro STR_ENDS_WITH "hello world" "Hello" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrEndsWith 9 : needle (wrong case) in the middle [NotFound]"
    !insertmacro STR_ENDS_WITH "the world is yours" "World" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrEndsWith 10 : needle (wrong case) at the end [Found]"
    !insertmacro STR_ENDS_WITH "hello world" "World" $0
    !insertmacro ASSERT_EQUALS $0 1 ; because NSIS string functions are case-insensitive

    DetailPrint " // StrEndsWith 11 : missing needle [NotFound]"
    !insertmacro STR_ENDS_WITH "hello world" "everybody" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrEndsWith 12 (Edge Case) : empty haystack with non-empty needle [NotFound]"
    !insertmacro STR_ENDS_WITH "" "test" $0
    !insertmacro ASSERT_EQUALS $0 0
SectionEnd
