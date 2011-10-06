#!/bin/bash
TAGS_BIN="/usr/bin/ctags"
SYSTAGS_OUT="$HOME/.vim/systags"
TAGFLIST="/usr/include/*"
RTAGFLIST="/usr/local/include/gtk-2.0/ \
/usr/include/sys/ \
/usr/include/bits/ \
/usr/local/include/glib-2.0/ \
/usr/local/include/mysql/ \
/usr/include/net \
/usr/include/netinet \
/usr/local/include/cairo \
/usr/local/include/curl"

CTAGS_FLAGS="–c-kinds=+p –fields=+iaS –extra=+q –language-force=c"

#[[ -x $CTAGS_BIN ]] && \
#$CTAGS_BIN –verbose $CTAGS_FLAGS -f $SYSTAGS_OUT $TAGFLIST -R $RTAGFLIST
ctags –c-kinds=+p –fields=+S -f $SYSTAGS_OUT $TAGFLIST -R $RTAGFLIST
ls -lh $SYSTAGS_OUT
