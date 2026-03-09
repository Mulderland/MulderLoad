!ifndef __HASDOTNETDESKTOPRUNTIME_NSH__
!define __HASDOTNETDESKTOPRUNTIME_NSH__

!include "..\..\includes\core\StackFrame.nsh"

Function HasDotnetDesktopRuntime
    !insertmacro STACKFRAME_BEGIN 1 3
    # $0 = major version (e.g. 8)

    StrCpy $R2 0
    FindFirst $R0 $R1 "$PROGRAMFILES64\dotnet\shared\Microsoft.WindowsDesktop.App\$0.*"
    IfErrors done
    StrCpy $R2 1
    FindClose $R0

    done:
    !insertmacro STACKFRAME_RETURN 1 3 $R2
    !insertmacro STACKFRAME_END 1 3
FunctionEnd

!ifmacrondef HAS_DOTNET_DESKTOP_RUNTIME
    !macro HAS_DOTNET_DESKTOP_RUNTIME VERSION RESULT
        Push "${VERSION}"
        Call HasDotnetDesktopRuntime
        Pop $0
    !macroend
!endif

!endif ; __HASDOTNETDESKTOPRUNTIME_NSH__
