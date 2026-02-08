!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will$\r$\n- download GZDoom from Github$\r$\n- download Return of the Triad v1.6$\r$\n- (optionally) Download the addon Scream of the Triad$\r$\n- (optionally) if you don't have Doom 1 or Doom 2 installed on your computer, you can also download Freedoom Phase 1 which is a good substitute."
!include "..\..\templates\standard.nsh"

Name "Return of the Triad"
InstallDir "C:\MulderLoad\Return of the Triad"

Section "Return of the Triad v1.6 + GZDoom v4.14"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://github.com/ZDoom/gzdoom/releases/download/g4.14.0/gzdoom-4-14-0a-windows.zip "gzdoom.zip"
    nsisunz::Unzip "gzdoom.zip" ".\"
    Delete "gzdoom.zip"

    !insertmacro Download https://www.mediafire.com/file_premium/fov7484ttj1bntq/rott_tc_16.zip/file "rott.zip"
    nsisunz::Unzip "rott.zip" ".\"
    Delete "rott.zip"
SectionEnd

Section "Addon - Scream of the Triad"
    SetOutPath $INSTDIR

    !insertmacro Download https://www.mediafire.com/file_premium/zv9c0s06tq70qgi/ROTT_ScreamTriad.zip/file "ROTT_ScreamTriad.zip"
    nsisunz::Unzip "ROTT_ScreamTriad.zip" ".\"
    Delete "ROTT_ScreamTriad.zip"
SectionEnd

Section /o "Freedoom: Phase 1 (if you don't have Doom or Doom 2 installed)"
    SetOutPath $INSTDIR

    !insertmacro Download https://github.com/freedoom/freedoom/releases/download/v0.13.0/freedoom-0.13.0.zip "freedoom.zip"
    nsisunz::Unzip /noextractpath /file "freedoom-0.13.0\freedoom1.wad" "freedoom.zip" ".\"
    Delete "freedoom.zip"
SectionEnd
