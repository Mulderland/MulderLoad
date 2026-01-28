!include "..\..\includes\functions\StrStartsWith.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

Section "StrStartsWith"
    DetailPrint " // StrStartsWith 1 (Edge Case) : empty needle [Found]"
    !insertmacro STR_STARTS_WITH "hello world" "" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrStartsWith 2 (Edge Case) : empty needle = empty haystack [Found]"
    !insertmacro STR_STARTS_WITH "" "" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrStartsWith 3 (Edge Case) : needle = haystack [Found]"
    !insertmacro STR_STARTS_WITH "hello world" "hello world" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrStartsWith 4 (Edge Case) : len(needle) > len(haystack) [NotFound]"
    !insertmacro STR_STARTS_WITH "hello world" "hello world and more" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrStartsWith 5 : needle at the beginning [Found]"
    !insertmacro STR_STARTS_WITH "hello world" "hello" $0
    !insertmacro ASSERT_EQUALS $0 1

    DetailPrint " // StrStartsWith 6 : needle in the middle [NotFound]"
    !insertmacro STR_STARTS_WITH "the world is yours" "world" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrStartsWith 7 : needle at the end [NotFound]"
    !insertmacro STR_STARTS_WITH "hello world" "world" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrStartsWith 8 : needle (wrong case) at the beginning [Found]"
    !insertmacro STR_STARTS_WITH "hello world" "Hello" $0
    !insertmacro ASSERT_EQUALS $0 1 ; because NSIS string functions are case-insensitive

    DetailPrint " // StrStartsWith 9 : needle (wrong case) in the middle [NotFound]"
    !insertmacro STR_STARTS_WITH "the world is yours" "World" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrStartsWith 10 : needle (wrong case) at the end [NotFound]"
    !insertmacro STR_STARTS_WITH "hello world" "World" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrStartsWith 11 : missing needle [NotFound]"
    !insertmacro STR_STARTS_WITH "hello world" "everybody" $0
    !insertmacro ASSERT_EQUALS $0 0

    DetailPrint " // StrStartsWith 12 (Edge Case) : empty haystack with non-empty needle [NotFound]"
    !insertmacro STR_STARTS_WITH "" "test" $0
    !insertmacro ASSERT_EQUALS $0 0
SectionEnd
