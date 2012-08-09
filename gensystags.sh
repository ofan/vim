#!/bin/bash
TAGS_BIN="`which ctags`"
SYSTAGS_OUT="$HOME/.vim/systags"
TAGFLIST=""
RTAGFLIST="/usr/include/ \
/opt/local/include"

CTAGS_FLAGS='--c-kinds=+p --fields=+iaS --extra=+q --language-force=c'

[[ -x $TAGS_BIN ]] && \
$TAGS_BIN --verbose $CTAGS_FLAGS -f $SYSTAGS_OUT $TAGFLIST -R $RTAGFLIST
#ctags –c-kinds=+p –fields=+S -f $SYSTAGS_OUT $TAGFLIST -R $RTAGFLIST
ls -lh $SYSTAGS_OUT
