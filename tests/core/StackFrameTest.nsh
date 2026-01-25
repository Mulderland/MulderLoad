!include "..\..\includes\functions\StrContains.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

Section "StackFrame"
    # Test 1
    DetailPrint " // StackFrame 1 : variable/registries are preserved"
    StrCpy $0 "Variable Zero"
    StrCpy $1 "Variable One"
    StrCpy $2 "Variable Two"
    StrCpy $R0 "Registry Zero"
    StrCpy $R1 "Registry One"
    StrCpy $R2 "Registry Two"

    # Call StrContains for example, which uses StackFrame. We don't care about the result ($9) here.
    !insertmacro STR_CONTAINS "une aiguille dans une botte de foin" "aiguille" $9

    # Check that all variables/registries are unchanged
    !insertmacro ASSERT_EQUALS $0 "Variable Zero"
    !insertmacro ASSERT_EQUALS $1 "Variable One"
    !insertmacro ASSERT_EQUALS $2 "Variable Two"
    !insertmacro ASSERT_EQUALS $R0 "Registry Zero"
    !insertmacro ASSERT_EQUALS $R1 "Registry One"
    !insertmacro ASSERT_EQUALS $R2 "Registry Two"

    # Test 2
    DetailPrint " // StackFrame 2 : stack arguments are consumed, other stack values are preserved"
    Push "Stack One"
    Push "Stack Two"
    Push "Stack Three"

    # Call StrContains for example, which uses StackFrame. We don't care about the result ($9) here.
    !insertmacro STR_CONTAINS "une aiguille dans une botte de foin" "aiguille" $9

    # Check that the other stack values are preserved
    Pop $9
    !insertmacro ASSERT_EQUALS $9 "Stack Three"
    Pop $9
    !insertmacro ASSERT_EQUALS $9 "Stack Two"
    Pop $9
    !insertmacro ASSERT_EQUALS $9 "Stack One"

    # Test 3
    DetailPrint " // StackFrame 3 : Multi-Return & Deep Stack Swap"
    StrCpy $R0 "PRECIOUS_R0"
    StrCpy $R1 "PRECIOUS_R1"
    StrCpy $R2 "PRECIOUS_R2"
    Call Test3Function

    # Check Returns (LIFO Order)
    Pop $0
    !insertmacro ASSERT_EQUALS $0 "RESULT_TOP"
    Pop $0
    !insertmacro ASSERT_EQUALS $0 "RESULT_BOTTOM"

    # 4. Check Integrity (No Swapping/Permutation)
    !insertmacro ASSERT_EQUALS $R0 "PRECIOUS_R0"
    !insertmacro ASSERT_EQUALS $R1 "PRECIOUS_R1"
    !insertmacro ASSERT_EQUALS $R2 "PRECIOUS_R2"
SectionEnd

Function Test3Function
    !insertmacro STACKFRAME_BEGIN 0 3

    # Overwrite locals
    StrCpy $R0 "TRASH_R0"
    StrCpy $R1 "TRASH_R1"
    StrCpy $R2 "TRASH_R2"

    # Multi returns
    !insertmacro STACKFRAME_RETURN 0 3 "RESULT_BOTTOM"
    !insertmacro STACKFRAME_RETURN 0 3 "RESULT_TOP"

    !insertmacro STACKFRAME_END 0 3
FunctionEnd
