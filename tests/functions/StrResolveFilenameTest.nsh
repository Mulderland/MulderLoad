!include "..\..\includes\functions\StrResolveFilename.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

Section "StrResolveFilename"
    DetailPrint " // StrResolveFilename 1 (Edge Case): empty [Empty]"
    !insertmacro STR_RESOLVE_FILENAME "" 0 $0
    !insertmacro ASSERT_EQUALS $0 ""
    !insertmacro STR_RESOLVE_FILENAME "" 1 $0
    !insertmacro ASSERT_EQUALS $0 ""

    DetailPrint " // StrResolveFilename 2 : A folder path [Empty]"
    !insertmacro STR_RESOLVE_FILENAME "/home/mulder/" 0 $0
    !insertmacro ASSERT_EQUALS $0 ""
    !insertmacro STR_RESOLVE_FILENAME "/home/mulder/" 1 $0
    !insertmacro ASSERT_EQUALS $0 ""
    !insertmacro STR_RESOLVE_FILENAME "C:\Users\mulder\" 0 $0
    !insertmacro ASSERT_EQUALS $0 ""
    !insertmacro STR_RESOLVE_FILENAME "C:\Users\mulder\" 1 $0
    !insertmacro ASSERT_EQUALS $0 ""

    DetailPrint " // StrResolveFilename 3 : A file (without extension) path [Filename]"
    !insertmacro STR_RESOLVE_FILENAME "/home/mulder/Filename" 0 $0
    !insertmacro ASSERT_EQUALS $0 "Filename"
    !insertmacro STR_RESOLVE_FILENAME "/home/mulder/Filename" 1 $0
    !insertmacro ASSERT_EQUALS $0 "Filename"
    !insertmacro STR_RESOLVE_FILENAME "C:\Users\mulder\Filename" 0 $0
    !insertmacro ASSERT_EQUALS $0 "Filename"
    !insertmacro STR_RESOLVE_FILENAME "C:\Users\mulder\Filename" 1 $0
    !insertmacro ASSERT_EQUALS $0 "Filename"

    DetailPrint " // StrResolveFilename 4a : A file (without name) path [Empty]"
    !insertmacro STR_RESOLVE_FILENAME "/home/mulder/.config" 0 $0
    !insertmacro ASSERT_EQUALS $0 ""
    !insertmacro STR_RESOLVE_FILENAME "C:\Users\mulder\.config" 0 $0
    !insertmacro ASSERT_EQUALS $0 ""

    DetailPrint " // StrResolveFilename 4b : A file (without name) path, keep_extension [.config]"
    !insertmacro STR_RESOLVE_FILENAME "/home/mulder/.config" 1 $0
    !insertmacro ASSERT_EQUALS $0 ".config"
    !insertmacro STR_RESOLVE_FILENAME "C:\Users\mulder\.config" 1 $0
    !insertmacro ASSERT_EQUALS $0 ".config"

    DetailPrint " // StrResolveFilename 5a : A file (with extension) path [Filename]"
    !insertmacro STR_RESOLVE_FILENAME "/home/mulder/Filename.ext" 0 $0
    !insertmacro ASSERT_EQUALS $0 "Filename"
    !insertmacro STR_RESOLVE_FILENAME "C:\Users\mulder\Filename.ext" 0 $0
    !insertmacro ASSERT_EQUALS $0 "Filename"

    DetailPrint " // StrResolveFilename 5b : A file (with extension) path, keep_extension [Filename.ext]"
    !insertmacro STR_RESOLVE_FILENAME "/home/mulder/Filename.ext" 1 $0
    !insertmacro ASSERT_EQUALS $0 "Filename.ext"
    !insertmacro STR_RESOLVE_FILENAME "C:\Users\mulder\Filename.ext" 1 $0
    !insertmacro ASSERT_EQUALS $0 "Filename.ext"

    DetailPrint " // StrResolveFilename 6a : A file (with double extension) path [Filename.tar]"
    !insertmacro STR_RESOLVE_FILENAME "/home/mulder/Filename.tar.gz" 0 $0
    !insertmacro ASSERT_EQUALS $0 "Filename.tar"
    !insertmacro STR_RESOLVE_FILENAME "C:\Users\mulder\Filename.tar.gz" 0 $0
    !insertmacro ASSERT_EQUALS $0 "Filename.tar"

    DetailPrint " // StrResolveFilename 6b : A file (with double extension) path, keep_extension [Filename.tar.gz]"
    !insertmacro STR_RESOLVE_FILENAME "/home/mulder/Filename.tar.gz" 1 $0
    !insertmacro ASSERT_EQUALS $0 "Filename.tar.gz"
    !insertmacro STR_RESOLVE_FILENAME "C:\Users\mulder\Filename.tar.gz" 1 $0
    !insertmacro ASSERT_EQUALS $0 "Filename.tar.gz"

    DetailPrint " // StrResolveFilename 7a : Filename only without path, no extension [Filename]"
    !insertmacro STR_RESOLVE_FILENAME "Filename" 0 $0
    !insertmacro ASSERT_EQUALS $0 "Filename"
    !insertmacro STR_RESOLVE_FILENAME "Filename" 1 $0
    !insertmacro ASSERT_EQUALS $0 "Filename"

    DetailPrint " // StrResolveFilename 7b : Filename only without path, with extension [Filename]"
    !insertmacro STR_RESOLVE_FILENAME "Filename.ext" 0 $0
    !insertmacro ASSERT_EQUALS $0 "Filename"

    DetailPrint " // StrResolveFilename 7c : Filename only without path, with extension, keep_extension [Filename.ext]"
    !insertmacro STR_RESOLVE_FILENAME "Filename.ext" 1 $0
    !insertmacro ASSERT_EQUALS $0 "Filename.ext"

    DetailPrint " // StrResolveFilename 8a : Multiple dots in filename [file.backup.2024.tar]"
    !insertmacro STR_RESOLVE_FILENAME "file.backup.2024.tar.gz" 0 $0
    !insertmacro ASSERT_EQUALS $0 "file.backup.2024.tar"

    DetailPrint " // StrResolveFilename 8b : Multiple dots in filename, keep_extension [file.backup.2024.tar.gz]"
    !insertmacro STR_RESOLVE_FILENAME "file.backup.2024.tar.gz" 1 $0
    !insertmacro ASSERT_EQUALS $0 "file.backup.2024.tar.gz"

    DetailPrint " // StrResolveFilename 9a : Multiple dots in filename with full path [file.backup.2024.tar]"
    !insertmacro STR_RESOLVE_FILENAME "/home/mulder/archive/file.backup.2024.tar.gz" 0 $0
    !insertmacro ASSERT_EQUALS $0 "file.backup.2024.tar"
    !insertmacro STR_RESOLVE_FILENAME "C:\Users\mulder\archive\file.backup.2024.tar.gz" 0 $0
    !insertmacro ASSERT_EQUALS $0 "file.backup.2024.tar"

    DetailPrint " // StrResolveFilename 9b : Multiple dots in filename with full path, keep_extension [file.backup.2024.tar.gz]"
    !insertmacro STR_RESOLVE_FILENAME "/home/mulder/archive/file.backup.2024.tar.gz" 1 $0
    !insertmacro ASSERT_EQUALS $0 "file.backup.2024.tar.gz"
    !insertmacro STR_RESOLVE_FILENAME "C:\Users\mulder\archive\file.backup.2024.tar.gz" 1 $0
    !insertmacro ASSERT_EQUALS $0 "file.backup.2024.tar.gz"
SectionEnd
