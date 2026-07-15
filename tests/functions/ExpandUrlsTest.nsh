!include "..\..\includes\functions\ExpandUrls.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

Section "ExpandUrls"
    DetailPrint " // _ExpandUrlCdn"
    Push "https://cdn.mulderload.eu/games/a-game/a-file.7z"
    Call _ExpandUrlCdn
    Pop $0
    !insertmacro ASSERT_EQUALS $0 "https://cdn.mulderload.eu/games/a-game/a-file.7z|https://cdn.de.mulderload.eu/games/a-game/a-file.7z"

    DetailPrint " // _ExpandUrlRedirectA (non-www)"
    Push "https://moddb.com/games/a-game/a-file.7z"
    Call _ExpandUrlRedirectA
    Pop $0
    !insertmacro ASSERT_EQUALS $0 "https://redirect.mulderload.eu/moddb.com/games/a-game/a-file.7z|https://redirecf.mulderload.eu/moddb.com/games/a-game/a-file.7z|https://redirect.de.mulderload.eu/moddb.com/games/a-game/a-file.7z"

    DetailPrint " // _ExpandUrlRedirectA (www)"
    Push "https://www.moddb.com/games/a-game/a-file.7z"
    Call _ExpandUrlRedirectA
    Pop $0
    !insertmacro ASSERT_EQUALS $0 "https://redirect.mulderload.eu/www.moddb.com/games/a-game/a-file.7z|https://redirecf.mulderload.eu/www.moddb.com/games/a-game/a-file.7z|https://redirect.de.mulderload.eu/www.moddb.com/games/a-game/a-file.7z"

    DetailPrint " // _ExpandUrlRedirectB (non-www)"
    Push "https://moddb.com/games/a-game/a-file.7z"
    Call _ExpandUrlRedirectB
    Pop $0
    !insertmacro ASSERT_EQUALS $0 "https://redirecf.mulderload.eu/moddb.com/games/a-game/a-file.7z|https://redirect.de.mulderload.eu/moddb.com/games/a-game/a-file.7z"

    DetailPrint " // _ExpandUrlRedirectB (www)"
    Push "https://www.moddb.com/games/a-game/a-file.7z"
    Call _ExpandUrlRedirectB
    Pop $0
    !insertmacro ASSERT_EQUALS $0 "https://redirecf.mulderload.eu/www.moddb.com/games/a-game/a-file.7z|https://redirect.de.mulderload.eu/www.moddb.com/games/a-game/a-file.7z"

    DetailPrint " // ExpandUrls 1: classic"
    !insertmacro EXPAND_URLS "https://www.classic.com/games/a-game/a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 "https://www.classic.com/games/a-game/a-file.7z"

    DetailPrint " // ExpandUrls 2: cdn"
    !insertmacro EXPAND_URLS "https://cdn.mulderload.eu/games/a-game/a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 "https://cdn.mulderload.eu/games/a-game/a-file.7z|https://cdn.de.mulderload.eu/games/a-game/a-file.7z"

    DetailPrint " // ExpandUrls 3: moddb"
    !insertmacro EXPAND_URLS "https://www.moddb.com/games/a-game/a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 "https://redirect.mulderload.eu/www.moddb.com/games/a-game/a-file.7z|https://redirecf.mulderload.eu/www.moddb.com/games/a-game/a-file.7z|https://redirect.de.mulderload.eu/www.moddb.com/games/a-game/a-file.7z"

    DetailPrint " // ExpandUrls 4: classic, cdn"
    !insertmacro EXPAND_URLS "https://www.classic.com/games/a-game/a-file.7z|https://cdn.mulderload.eu/games/a-game/a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 "https://www.classic.com/games/a-game/a-file.7z|https://cdn.mulderload.eu/games/a-game/a-file.7z|https://cdn.de.mulderload.eu/games/a-game/a-file.7z"

    DetailPrint " // ExpandUrls 5: cdn, classic"
    !insertmacro EXPAND_URLS "https://cdn.mulderload.eu/games/a-game/a-file.7z|https://www.classic.com/games/a-game/a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 "https://cdn.mulderload.eu/games/a-game/a-file.7z|https://cdn.de.mulderload.eu/games/a-game/a-file.7z|https://www.classic.com/games/a-game/a-file.7z"

    DetailPrint " // ExpandUrls 6: cdn, moddb, classic"
    !insertmacro EXPAND_URLS "https://cdn.mulderload.eu/games/a-game/a-file.7z|https://www.moddb.com/games/a-game/a-file.7z|https://www.classic.com/games/a-game/a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 "https://cdn.mulderload.eu/games/a-game/a-file.7z|https://cdn.de.mulderload.eu/games/a-game/a-file.7z|https://redirect.mulderload.eu/www.moddb.com/games/a-game/a-file.7z|https://redirecf.mulderload.eu/www.moddb.com/games/a-game/a-file.7z|https://redirect.de.mulderload.eu/www.moddb.com/games/a-game/a-file.7z|https://www.classic.com/games/a-game/a-file.7z"
SectionEnd
