!ifndef __TESTMACROS_NSH__
!define __TESTMACROS_NSH__

!include "LogicLib.nsh"

Var /GLOBAL NB_TESTS
Var /GLOBAL NB_ERRORS

!ifmacrondef INIT_STATS
    !macro INIT_STATS
        Section
            StrCpy $NB_TESTS 0
            StrCpy $NB_ERRORS 0
        SectionEnd
    !macroend
!endif

!ifmacrondef PRINT_STATS
    !macro PRINT_STATS
        Section
            DetailPrint "===================== Tests Summary ====================="
            DetailPrint " Total Tests Run: $NB_TESTS"
            DetailPrint " Total Errors  : $NB_ERRORS"
            DetailPrint "========================================================="
        SectionEnd
    !macroend
!endif

!ifmacrondef ASSERT_EQUALS
    !macro ASSERT_EQUALS result expected
        IntOp $NB_TESTS $NB_TESTS + 1

        ${If} "${result}" == "${expected}"
            DetailPrint "OK"
        ${Else}
            IntOp $NB_ERRORS $NB_ERRORS + 1
            DetailPrint "FAILED (got ${result}, expected ${expected})"
        ${EndIf}
    !macroend
!endif

!endif ; __TESTMACROS_NSH__
