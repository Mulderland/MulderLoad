!include "..\..\includes\functions\StrCount.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

Section "StrCount"
    DetailPrint " // StrCount 1 - one occurrence"
    !insertmacro STR_COUNT "Hello World" "World" $0
    !insertmacro ASSERT_EQUALS $0 "1"

    DetailPrint " // StrCount 2 - multiple occurrences"
    !insertmacro STR_COUNT "foo\bar\foo\baz\foo" "foo" $0
    !insertmacro ASSERT_EQUALS $0 "3"

    DetailPrint " // StrCount 3 - no occurrence"
    !insertmacro STR_COUNT "Hello World" "xyz" $0
    !insertmacro ASSERT_EQUALS $0 "0"

    DetailPrint " // StrCount 4 - single character"
    !insertmacro STR_COUNT "Binaries\Win32" "\" $0
    !insertmacro ASSERT_EQUALS $0 "1"

    DetailPrint " // StrCount 5 - multiple separators"
    !insertmacro STR_COUNT "A\B\C\D" "\" $0
    !insertmacro ASSERT_EQUALS $0 "3"

    DetailPrint " // StrCount 6 - string at beginning"
    !insertmacro STR_COUNT "foobar" "foo" $0
    !insertmacro ASSERT_EQUALS $0 "1"

    DetailPrint " // StrCount 7 - string at end"
    !insertmacro STR_COUNT "foobar" "bar" $0
    !insertmacro ASSERT_EQUALS $0 "1"

    DetailPrint " // StrCount 8 - string equals haystack"
    !insertmacro STR_COUNT "foobar" "foobar" $0
    !insertmacro ASSERT_EQUALS $0 "1"

    DetailPrint " // StrCount 9 - empty haystack"
    !insertmacro STR_COUNT "" "foo" $0
    !insertmacro ASSERT_EQUALS $0 "0"

    DetailPrint " // StrCount 10 - empty needle"
    !insertmacro STR_COUNT "foobar" "" $0
    !insertmacro ASSERT_EQUALS $0 "0"

    DetailPrint " // StrCount 11 - needle longer than haystack"
    !insertmacro STR_COUNT "foo" "foobar" $0
    !insertmacro ASSERT_EQUALS $0 "0"

    DetailPrint " // StrCount 12 - overlapping occurrences"
    !insertmacro STR_COUNT "aaa" "aa" $0
    !insertmacro ASSERT_EQUALS $0 "1"
SectionEnd
