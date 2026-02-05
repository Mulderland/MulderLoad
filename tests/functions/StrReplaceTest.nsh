!include "..\..\includes\functions\StrReplace.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

Section "StrReplace"
    DetailPrint " // StrReplace 1 (Edge case) : empty haystack"
    !insertmacro STR_REPLACE "x" "y" "" $0
    !insertmacro ASSERT_EQUALS $0 ""

    DetailPrint " // StrReplace 2 (Edge case) : empty search"
    !insertmacro STR_REPLACE "" "X" "abc" $0
    !insertmacro ASSERT_EQUALS $0 "abc"

    DetailPrint " // StrReplace 3 (Edge case) : length(search) > length(haystack)"
    !insertmacro STR_REPLACE "toolongstring" "x" "abc" $0
    !insertmacro ASSERT_EQUALS $0 "abc"

    DetailPrint " // StrReplace 4 (Edge case) : replacement with overlapping risk"
    !insertmacro STR_REPLACE "a" "ab" "aaa" $0
    !insertmacro ASSERT_EQUALS $0 "ababab"

    DetailPrint " // StrReplace 5 (Edge case) : another replacement with overlapping risk"
    !insertmacro STR_REPLACE "a" "aaa" "banana" $0
    !insertmacro ASSERT_EQUALS $0 "baaanaaanaaa"

    DetailPrint " // StrReplace 6 (Edge case) : empty replacement string (total deletion)"
    !insertmacro STR_REPLACE "this is his island" "" "this is his island" $0
    !insertmacro ASSERT_EQUALS $0 ""

    DetailPrint " // StrReplace 7 : empty replacement string (partial deletion)"
    !insertmacro STR_REPLACE "is" "" "this is his island" $0
    !insertmacro ASSERT_EQUALS $0 "th  h land"

    DetailPrint " // StrReplace 8 : single occurrence"
    !insertmacro STR_REPLACE "world" "everybody" "hello world" $0
    !insertmacro ASSERT_EQUALS $0 "hello everybody"

    DetailPrint " // StrReplace 9 : multiple occurrences"
    !insertmacro STR_REPLACE "happy" "merry" "happy christmas and happy new year" $0
    !insertmacro ASSERT_EQUALS $0 "merry christmas and merry new year"

    DetailPrint " // StrReplace 10 : no occurrences"
    !insertmacro STR_REPLACE "moon" "sun" "the sky is blue" $0
    !insertmacro ASSERT_EQUALS $0 "the sky is blue"

    DetailPrint " // StrReplace 11 : search at the beginning"
    !insertmacro STR_REPLACE "hello" "hi" "hello world" $0
    !insertmacro ASSERT_EQUALS $0 "hi world"

    DetailPrint " // StrReplace 12 : search at the end"
    !insertmacro STR_REPLACE "world" "everyone" "hello world" $0
    !insertmacro ASSERT_EQUALS $0 "hello everyone"

    DetailPrint " // StrReplace 13 : case-insensitive search"
    !insertmacro STR_REPLACE "Hello" "hi" "hello world" $0
    !insertmacro ASSERT_EQUALS $0 "hi world"
SectionEnd
