!include "..\..\includes\functions\GetParentDirectory.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

!include "..\..\includes\functions\GetParentDirectory.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

Section "GetParentDirectory"
    DetailPrint " // GetParentDirectory 1 - executable"
    !insertmacro GET_PARENT_DIRECTORY "C:\Games\MyGame\Game.exe" 1 $0
    !insertmacro ASSERT_EQUALS $0 "C:\Games\MyGame"

    DetailPrint " // GetParentDirectory 2 - one subdirectory"
    !insertmacro GET_PARENT_DIRECTORY "C:\Games\MyGame\Binaries\Game.exe" 2 $0
    !insertmacro ASSERT_EQUALS $0 "C:\Games\MyGame"

    DetailPrint " // GetParentDirectory 3 - two subdirectories"
    !insertmacro GET_PARENT_DIRECTORY "C:\Games\MyGame\Binaries\Win32\Game.exe" 3 $0
    !insertmacro ASSERT_EQUALS $0 "C:\Games\MyGame"

    DetailPrint " // GetParentDirectory 4 - x86"
    !insertmacro GET_PARENT_DIRECTORY "C:\Games\MyGame\x86\Game.exe" 2 $0
    !insertmacro ASSERT_EQUALS $0 "C:\Games\MyGame"

    DetailPrint " // GetParentDirectory 5 - x86-64"
    !insertmacro GET_PARENT_DIRECTORY "C:\Games\MyGame\x86-64\Game.exe" 2 $0
    !insertmacro ASSERT_EQUALS $0 "C:\Games\MyGame"

    DetailPrint " // GetParentDirectory 6 - zero parents"
    !insertmacro GET_PARENT_DIRECTORY "C:\Games\MyGame\Game.exe" 0 $0
    !insertmacro ASSERT_EQUALS $0 "C:\Games\MyGame\Game.exe"

    DetailPrint " // GetParentDirectory 7 - directory without trailing slash"
    !insertmacro GET_PARENT_DIRECTORY "C:\Games\MyGame" 1 $0
    !insertmacro ASSERT_EQUALS $0 "C:\Games"

    DetailPrint " // GetParentDirectory 8 - directory with trailing slash"
    !insertmacro GET_PARENT_DIRECTORY "C:\Games\MyGame\" 1 $0
    !insertmacro ASSERT_EQUALS $0 "C:\Games"

    DetailPrint " // GetParentDirectory 9 - nested directory without trailing slash"
    !insertmacro GET_PARENT_DIRECTORY "C:\Games\MyGame\Binaries\Win32" 2 $0
    !insertmacro ASSERT_EQUALS $0 "C:\Games\MyGame"

    DetailPrint " // GetParentDirectory 10 - nested directory with trailing slash"
    !insertmacro GET_PARENT_DIRECTORY "C:\Games\MyGame\Binaries\Win32\" 2 $0
    !insertmacro ASSERT_EQUALS $0 "C:\Games\MyGame"
SectionEnd

