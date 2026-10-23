!include "..\..\includes\functions\WineDllOverride.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

# Only fake names are used, so a real Wine prefix is never altered
!define WINE_TEST_EXE "MulderLoadTest.exe"
!define WINE_TEST_GLOBAL_KEY "Software\Wine\DllOverrides"
!define WINE_TEST_APP_KEY "Software\Wine\AppDefaults\${WINE_TEST_EXE}\DllOverrides"

# Read a registry value, or "<missing>" if it doesn't exist
!macro _WINE_TEST_READ KEY NAME RESULT
    ClearErrors
    ReadRegStr ${RESULT} HKCU "${KEY}" "${NAME}"
    ${If} ${Errors}
        StrCpy ${RESULT} "<missing>"
    ${EndIf}
!macroend

Section "WineDllOverride"
    # Force the OS detection result (DetectOS is memoized), restored at the end
    StrCpy $R9 $_DetectOS_Memoize

    DetailPrint " // WineDllOverride 1 : Windows detected [Nothing written]"
    StrCpy $_DetectOS_Memoize "Windows"
    !insertmacro WINE_DLL_OVERRIDE_APP "${WINE_TEST_EXE}" "mldtest_a" "native,builtin"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_a" $0
    !insertmacro ASSERT_EQUALS $0 "<missing>"

    StrCpy $_DetectOS_Memoize "Linux"

    DetailPrint " // WineDllOverride 2 : per-app override"
    !insertmacro WINE_DLL_OVERRIDE_APP "${WINE_TEST_EXE}" "mldtest_a" "native,builtin"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_a" $0
    !insertmacro ASSERT_EQUALS $0 "native,builtin"

    DetailPrint " // WineDllOverride 3 : per-app override, exe given with full path"
    !insertmacro WINE_DLL_OVERRIDE_APP "C:\Some Folder\${WINE_TEST_EXE}" "mldtest_b" "builtin"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_b" $0
    !insertmacro ASSERT_EQUALS $0 "builtin"

    DetailPrint " // WineDllOverride 4 : existing override is replaced"
    !insertmacro WINE_DLL_OVERRIDE_APP "${WINE_TEST_EXE}" "mldtest_a" "native"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_a" $0
    !insertmacro ASSERT_EQUALS $0 "native"

    DetailPrint " // WineDllOverride 5 : list of dlls, with .dll suffix and spaces"
    !insertmacro WINE_DLL_OVERRIDE_APP "${WINE_TEST_EXE}" "mldtest_c.dll, mldtest_d ,MLDTEST_E.DLL" "native,builtin"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_c" $0
    !insertmacro ASSERT_EQUALS $0 "native,builtin"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_d" $0
    !insertmacro ASSERT_EQUALS $0 "native,builtin"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_e" $0
    !insertmacro ASSERT_EQUALS $0 "native,builtin"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_c.dll" $0
    !insertmacro ASSERT_EQUALS $0 "<missing>"

    DetailPrint " // WineDllOverride 6 (Edge Case) : empty entries in list are ignored"
    !insertmacro WINE_DLL_OVERRIDE_APP "${WINE_TEST_EXE}" ",mldtest_f,,.dll," "native,builtin"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_f" $0
    !insertmacro ASSERT_EQUALS $0 "native,builtin"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "" $0
    !insertmacro ASSERT_EQUALS $0 "<missing>"

    DetailPrint " // WineDllOverride 7 : disabled"
    !insertmacro WINE_DLL_OVERRIDE_APP "${WINE_TEST_EXE}" "mldtest_g" "disabled"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_g" $0
    !insertmacro ASSERT_EQUALS $0 "disabled"

    DetailPrint " // WineDllOverride 8 : remove"
    !insertmacro WINE_DLL_OVERRIDE_APP "${WINE_TEST_EXE}" "mldtest_a,mldtest_g" "remove"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_a" $0
    !insertmacro ASSERT_EQUALS $0 "<missing>"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_g" $0
    !insertmacro ASSERT_EQUALS $0 "<missing>"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_APP_KEY}" "mldtest_b" $0
    !insertmacro ASSERT_EQUALS $0 "builtin" ; untouched

    DetailPrint " // WineDllOverride 9 : global override"
    !insertmacro WINE_DLL_OVERRIDE "mldtest_h" "native,builtin"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_GLOBAL_KEY}" "mldtest_h" $0
    !insertmacro ASSERT_EQUALS $0 "native,builtin"

    DetailPrint " // WineDllOverride 10 : global remove"
    !insertmacro WINE_DLL_OVERRIDE "mldtest_h" "remove"
    !insertmacro _WINE_TEST_READ "${WINE_TEST_GLOBAL_KEY}" "mldtest_h" $0
    !insertmacro ASSERT_EQUALS $0 "<missing>"

    DetailPrint " // WineDllOverride 11 : registers are preserved"
    StrCpy $0 "zero"
    StrCpy $1 "one"
    StrCpy $2 "two"
    StrCpy $R0 "r0"
    StrCpy $R4 "r4"
    !insertmacro WINE_DLL_OVERRIDE_APP "${WINE_TEST_EXE}" "mldtest_i,mldtest_j" "native,builtin"
    !insertmacro ASSERT_EQUALS "$0|$1|$2|$R0|$R4" "zero|one|two|r0|r4"

    # Cleanup: remove the test app key, then only remove parent keys if we left them empty.
    # On Windows, a leftover HKCU\Software\Wine subkey would make DetectOS lean towards Linux.
    DeleteRegKey HKCU "Software\Wine\AppDefaults\${WINE_TEST_EXE}"
    DeleteRegKey /ifempty HKCU "Software\Wine\AppDefaults"
    DeleteRegKey /ifempty HKCU "${WINE_TEST_GLOBAL_KEY}"
    DeleteRegKey /ifempty HKCU "Software\Wine"

    StrCpy $_DetectOS_Memoize $R9
SectionEnd

!undef WINE_TEST_EXE
!undef WINE_TEST_GLOBAL_KEY
!undef WINE_TEST_APP_KEY
