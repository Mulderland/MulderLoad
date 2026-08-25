!ifndef __DETECTOS_NSH__
!define __DETECTOS_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"

Var /GLOBAL _DetectOS_Memoize

Function DetectOS
    !insertmacro STACKFRAME_BEGIN 0 3
    # $R0: number of successful tests
    # $R1: temp
    # $R2: result

    ${If} $_DetectOS_Memoize == "Windows"
    ${OrIf} $_DetectOS_Memoize == "Linux"
        Goto DetectOS_end
    ${EndIf}

    StrCpy $R0 0

    # Look for Wine
    EnumRegKey $R1 HKCU "Software\Wine" ""
    ${If} $R1 != ""
        IntOp $R0 $R0 + 1
    ${EndIf}

    # Look for a common Linux folder
    ${If} ${FileExists} "Z:\usr\*.*"
        IntOp $R0 $R0 + 1
    ${EndIf}

    # Look for a common Linux file
    ${If} ${FileExists} "Z:\etc\os-release"
        IntOp $R0 $R0 + 1
    ${ElseIf} ${FileExists} "Z:\usr\lib\os-release"
        IntOp $R0 $R0 + 1
    ${EndIf}

    # Put the detected OS in $R2 (ask the user if ambiguous)
    ${If} $R0 = 0
        StrCpy $R2 "Windows"
    ${ElseIf} $R0 = 3
        StrCpy $R2 "Linux"
    ${Else}
        StrCpy $R2 "Windows"
        ${If} $R0 = 2
            # Ask user, with Yes pre-selected
            MessageBox MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON1 "Are you on Steam Deck (or Linux)?" IDNO +2
            StrCpy $R2 "Linux"
        ${Else}
            # Ask user, with No pre-selected
            MessageBox MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2 "Are you on Steam Deck (or Linux)?" IDNO +2
            StrCpy $R2 "Linux"
        ${EndIf}
    ${EndIf}

    # Save result globally to avoid detecting again
    StrCpy $_DetectOS_Memoize $R2

    DetectOS_end:
    !insertmacro STACKFRAME_RETURN 0 3 $_DetectOS_Memoize
    !insertmacro STACKFRAME_END 0 3
FunctionEnd

!ifmacrondef DETECT_OS
    !macro DETECT_OS RESULT
        Call DetectOS
        Pop ${RESULT}
    !macroend
!endif

!endif ; __DETECTOS_NSH__
