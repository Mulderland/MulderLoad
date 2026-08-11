!define MUI_WELCOMEPAGE_TEXT "This installer requires a user-provided image of the original Xbox 360 DVD of The Simpsons Game.$\r$\n\
$\r$\n\
It will verify the integrity of the provided image, install SimpsonsGame-Recompiled (the unofficial PC port), and extract the game files to the installation folder.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}$\r$\n\
$\r$\n\
Special thanks to YesterMester for successfully bringing this great Simpsons game (arguably the best one since Hit && Run) to the PC platform!$\r$\n\
$\r$\n\
This installer and the PC port are not affiliated with or endorsed by Disney, EA or any of the original developers."

!include "..\..\includes\templates\ByofTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\I6Comp.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "The Simpsons Game"
InstallDir "E:\MulderLoad\The Simpsons Game"

; ...................................................Europe (Danish, English, Finnish, Norwegian)......Europe (Italian, Spanish)........................USA.......................................Germany.............................France....................
!insertmacro BYOF_DEFINE "DVD" "Image files|*.iso" "101f34f12530704cd1b985f339ae2a7c21cd72b1,6f664a6832298c9cdb3db3e02703121ab3f53aed,7729aae27c5035d20717be9694d007fb9da444dc,9838409efea0c6cc8b97526722d4a39f323e3ca9,7ff5432e397e80b9a2b19c12652413b2acdfc89a"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Section "TheSimpsonsGame-Recompiled (unofficial PC port)"
    SetOutPath "$INSTDIR"

    DetailPrint " // Get TheSimpsonsGame-Recompiled"
    !insertmacro DOWNLOAD_2 "https://github.com/YesterMester/TheSimpsonsGameRecomp/releases/download/v0.0.5.4/TheSimpsonsGame-Recompiled-Windows-x64.zip" \
                            "https://cdn.mulderload.eu/games/the-simpsons-game/port/TheSimpsonsGame-Recompiled-Windows-x64-v0.0.5.4.zip" \
                            "TheSimpsonsGame-Recompiled-Windows-x64.zip" \
                            "c5573bd13f4ec9f844fe3e67dbb98c4258720dfa9a83d9f9a1d3b3e590097d41"

    !insertmacro NSISUNZ_EXTRACT "TheSimpsonsGame-Recompiled-Windows-x64.zip" ".\" "AUTO_DELETE"
    AddSize 445306
SectionEnd

Section "Extract game files from DVD image"
    SetOutPath "$INSTDIR"

    DetailPrint " // Get latest extract-xiso"
    !insertmacro DOWNLOAD_2 "https://github.com/XboxDev/extract-xiso/releases/download/build-202505152050/extract-xiso-Win64_Release.zip" \
                            "https://cdn.mulderload.eu/dependencies/extract-xiso/build-202505152050/extract-xiso-Win64_Release.zip" \
                            "extract-xiso.zip" \
                            "3919da8c7e36f31eb957bf2696d272c67ba77ca7"

    !insertmacro NSISUNZ_EXTRACT_ONE "extract-xiso.zip" ".\" "artifacts\extract-xiso.exe" "AUTO_DELETE"
    AddSize -1078 # size of the shipped extract-xiso.exe
    AddSize 40 # size of the extract-xiso.exe from github

    DetailPrint " // Extracting game files from DVD image"
    nsExec::ExecToStack '"$INSTDIR\extract-xiso.exe" -x -d gamedata "$byofPath_DVD"'
    AddSize 4282303
SectionEnd
