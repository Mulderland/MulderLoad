!include "..\..\includes\functions\StrRightExplode.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

Section "StrRightExplode"
    DetailPrint " // StrRightExplode 1 (Edge case): empty delimiter [Original,Empty]"
    !insertmacro STR_RIGHT_EXPLODE "" "C:\Users\Mulder\Archive.tar.gz" $0 $1
    !insertmacro ASSERT_EQUALS $0 "C:\Users\Mulder\Archive.tar.gz"
    !insertmacro ASSERT_EQUALS $1 ""

    DetailPrint " // StrRightExplode 2 (Edge case): delimiter not found [Original,Empty]"
    !insertmacro STR_RIGHT_EXPLODE "-" "C:\Users\Mulder\Archive.tar.gz" $0 $1
    !insertmacro ASSERT_EQUALS $0 "C:\Users\Mulder\Archive.tar.gz"
    !insertmacro ASSERT_EQUALS $1 ""

    DetailPrint " // StrRightExplode 3 (Edge case): case-insensitive match [Modified,Modified]"
    !insertmacro STR_RIGHT_EXPLODE "users" "C:\Users\Mulder\Archive.tar.gz" $0 $1
    !insertmacro ASSERT_EQUALS $0 "C:\"
    !insertmacro ASSERT_EQUALS $1 "\Mulder\Archive.tar.gz"

    DetailPrint " // StrRightExplode 4 (Edge case): length(delimiter) > length(string) [Original,Empty]"
    !insertmacro STR_RIGHT_EXPLODE "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" "C:\Users\Mulder\Archive.tar.gz" $0 $1
    !insertmacro ASSERT_EQUALS $0 "C:\Users\Mulder\Archive.tar.gz"
    !insertmacro ASSERT_EQUALS $1 ""

    DetailPrint " // StrRightExplode 5 (Edge case): delimiter = string [Empty,Empty]"
    !insertmacro STR_RIGHT_EXPLODE "C:\Users\Mulder\Archive.tar.gz" "C:\Users\Mulder\Archive.tar.gz" $0 $1
    !insertmacro ASSERT_EQUALS $0 ""
    !insertmacro ASSERT_EQUALS $1 ""

    DetailPrint " // StrRightExplode 6 (Edge case): case-insensitive finds rightmost match [Modified,Modified]"
    !insertmacro STR_RIGHT_EXPLODE "C" "C:\Users\Mulder\Archive.tar.gz" $0 $1
    !insertmacro ASSERT_EQUALS $0 "C:\Users\Mulder\Ar"
    !insertmacro ASSERT_EQUALS $1 "hive.tar.gz"

    DetailPrint " // StrRightExplode 7 (Edge case): delimiter at the end [Modified,Empty]"
    !insertmacro STR_RIGHT_EXPLODE ".gz" "C:\Users\Mulder\Archive.tar.gz" $0 $1
    !insertmacro ASSERT_EQUALS $0 "C:\Users\Mulder\Archive.tar"
    !insertmacro ASSERT_EQUALS $1 ""

    DetailPrint " // StrRightExplode 8"
    !insertmacro STR_RIGHT_EXPLODE "\" "C:\Users\Mulder\Archive.tar.gz" $0 $1
    !insertmacro ASSERT_EQUALS $0 "C:\Users\Mulder"
    !insertmacro ASSERT_EQUALS $1 "Archive.tar.gz"

    DetailPrint " // StrRightExplode 9"
    !insertmacro STR_RIGHT_EXPLODE "***" "b4d944af1d***40f25e634c" $0 $1
    !insertmacro ASSERT_EQUALS $0 "b4d944af1d"
    !insertmacro ASSERT_EQUALS $1 "40f25e634c"

    DetailPrint " // StrRightExplode 10"
    !insertmacro STR_RIGHT_EXPLODE "_" "A_B_C" $0 $1
    !insertmacro ASSERT_EQUALS $0 "A_B"
    !insertmacro ASSERT_EQUALS $1 "C"
SectionEnd
