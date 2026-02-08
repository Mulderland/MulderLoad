!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS test runner from the MulderLoad project."
!include "..\..\includes\templates\ClassicTemplate.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

Name "Test Runner"
InstallDir "C:\MulderLoad\Tests"

!insertmacro INIT_STATS
!include "..\..\tests\core\StackFrameTest.nsh"
!include "..\..\tests\functions\FileStrReplaceTest.nsh"
!include "..\..\tests\functions\StrContainsTest.nsh"
!include "..\..\tests\functions\StrEndsWithTest.nsh"
!include "..\..\tests\functions\StrReplaceTest.nsh"
!include "..\..\tests\functions\StrRightExplodeTest.nsh"
!include "..\..\tests\functions\StrStartsWithTest.nsh"
!insertmacro PRINT_STATS
