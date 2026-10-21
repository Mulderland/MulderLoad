!ifndef __DETECTOS_NSH__
!define __DETECTOS_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"

Var /GLOBAL _DetectOS_Memoize

# Returns "Windows" or "Linux", decided by a weighted vote of 5 independent detections.
# Wine's ntdll weighs as much as the 4 other detections combined (score out of 8):
#   0: Windows | 1-2: ask, No pre-selected | 3-4: ask, Yes pre-selected | 5-8: Linux (ntdll + at least 1 other)
Function DetectOS
    !insertmacro STACKFRAME_BEGIN 0 4
    # $R0: score (out of 8)
    # $R1: temp
    # $R2: result
    # $R3: ntdll.dll handle

    ${If} $_DetectOS_Memoize == "Windows"
    ${OrIf} $_DetectOS_Memoize == "Linux"
        Goto DetectOS_end
    ${EndIf}

    StrCpy $R0 0

    # 1. Look for Wine's ntdll (Windows' ntdll doesn't export wine_get_version), the most reliable detection
    System::Call 'kernel32::GetModuleHandle(t "ntdll.dll") p .R3'
    System::Call 'kernel32::GetProcAddress(p R3, m "wine_get_version") p .R1'
    ${If} $R1 P<> 0
        IntOp $R0 $R0 + 4
    ${EndIf}

    # 2. Look for a Wine prefix tool
    ${If} ${FileExists} "$SYSDIR\winecfg.exe"
        IntOp $R0 $R0 + 1
    ${EndIf}

    # 3. Look for a common Linux folder
    ${If} ${FileExists} "\\?\unix\usr\*.*"
        IntOp $R0 $R0 + 1
    ${EndIf}

    # 4. Look for a common Linux file
    ${If} ${FileExists} "\\?\unix\etc\os-release"
        IntOp $R0 $R0 + 1
    ${ElseIf} ${FileExists} "\\?\unix\usr\lib\os-release"
        IntOp $R0 $R0 + 1
    ${EndIf}

    # 5. Look for the Linux kernel's procfs
    ${If} ${FileExists} "\\?\unix\proc\version"
        IntOp $R0 $R0 + 1
    ${EndIf}

    # Put the detected OS in $R2 (ask the user if ambiguous, with the most likely answer pre-selected)
    ${If} $R0 = 0
        StrCpy $R2 "Windows"
    ${ElseIf} $R0 >= 5
        StrCpy $R2 "Linux"
    ${Else}
        StrCpy $R2 "Windows"
        ${If} $R0 >= 3
            # Ask user, with Yes pre-selected
            MessageBox MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON1 "Are you on Linux (or Steam Deck/Machine)?" /SD IDYES IDNO +2
            StrCpy $R2 "Linux"
        ${Else}
            # Ask user, with No pre-selected
            MessageBox MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2 "Are you on Linux (or Steam Deck/Machine)?" /SD IDNO IDNO +2
            StrCpy $R2 "Linux"
        ${EndIf}
    ${EndIf}

    # Save result globally to avoid detecting again
    StrCpy $_DetectOS_Memoize $R2

    DetectOS_end:
    !insertmacro STACKFRAME_RETURN 0 4 $_DetectOS_Memoize
    !insertmacro STACKFRAME_END 0 4
FunctionEnd

!ifmacrondef DETECT_OS
    !macro DETECT_OS RESULT
        Call DetectOS
        Pop ${RESULT}
    !macroend
!endif

!endif ; __DETECTOS_NSH__
