" vim: ts=4 sw=4

" Determine platform
let g:is_Win = 0
let g:is_Mac = 0
let g:is_Linux = 0
let g:is_Cygwin = 0

if has("win32") || has("win64")
    let g:is_Win=1
else
    if has("mac") || has("macunix")
        let g:is_Mac=1
    elseif has("win32unix")
        let g:is_Win = 0
        let g:is_Linux = 0
        let g:is_Cygwin = 1
    else
        let g:is_Linux = 1
    endif
endif

if g:is_Win
    "set termencoding=utf8
    set encoding=utf8
else
    set termencoding=utf8
endif

" Script encoding
scriptencoding utf-8

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle settings
filetype off                   " required!

let win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'
let vimDir = win_shell ? '$HOME/vimfiles' : '$HOME/.vim'
let &runtimepath .= ',' . expand(vimDir . '/bundle/vundle')

call plug#begin(expand(vimDir . '/plugged'))
" {{{ Plugins
" {{{ UI extensions
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
" }}}
" {{{ File types and highlighting
Plug 'chrisbra/csv.vim', {'for' : 'csv'}
Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'klen/python-mode', {'for' : 'python'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'reinh/vim-makegreen', {'on' : 'MakeGreen'} " Highlight compiler/tests output
" Haskell plugins
Plug 'lukerandall/haskellmode-vim', {'for': 'haskell'}
if !g:is_Win
    Plug 'Twinside/vim-haskellConceal'
endif
Plug 'Twinside/vim-haskellFold', {'for': 'haskell'}
Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}
Plug 'wlangstroth/vim-haskell', {'for': 'haskell'}
Plug 'bitc/lushtags', {'for': 'haskell'}
" }}}
" {{{ Productivity
Plug 'chrisbra/NrrwRgn'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdcommenter' " Toggle comments for various file types
Plug 'mattn/emmet-vim', {'for': ['html', 'xml', 'css']} " Generate tags based on rules
" }}}
" {{{ Integration
Plug 'fs111/pydoc.vim', {'for': 'python'}
Plug 'alfredodeza/pytest.vim', {'for': 'python'}
Plug 'ujihisa/repl.vim' | Plug 'Shougo/vimproc'
Plug 'tpope/vim-git'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter', {'on': ['GitGutterToggle', 'GitGutterEnable']}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/vimshell'
"    _DISABLED_ Plug 'xaviershay/tslime.vim' " TMUX
Plug 'tpope/vim-fugitive'
Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
Plug 'mattn/gist-vim' " Github gist
" }}}
" {{{ Themes or decorators
Plug 'altercation/vim-colors-solarized'
Plug 'stephenmckinney/vim-solarized-powerline'
Plug 'bling/vim-airline'
Plug 'jimenezrick/vimerl'
" }}}
" {{{ Completion
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', {'for': ['c', 'cpp'], 'frozen': 1}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'Shougo/neocomplete.vim'
Plug 'ludovicchabant/vim-gutentags'
" }}}
" {{{ Text editing
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
" }}}
" {{{ Misc
Plug 'ryanoasis/vim-devicons'
" Misc or dependencies
Plug 'mattn/webapi-vim'
" }}}
" {{{ Plugins from vim-scripts
Plug 'TaskList.vim'
Plug 'vimwiki'
Plug 'VOoM'
Plug 'TxtBrowser'
Plug 'FuzzyFinder'
Plug 'DoxygenToolkit.vim'
Plug 'L9'
Plug 'dbext.vim'
Plug 'QuickBuf'
Plug 'DrawIt'
" }}}
" }}}
call plug#end()

" Vim-Plug settings
let g:plug_timeout = 600

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup        " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
set history=800        " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd        " display incomplete commands
set incsearch        " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff "menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
  if expand("$TERM_PROGRAM") == "Apple_Terminal"
      set ttymouse=xterm2
  endif
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " 加载 pathogen
    "call pathogen#runtime_append_all_bundles()

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

" Customized settings
"

" Clipboard settings
if g:is_Mac
    if has("clipboard") && !has("gui_running")
        set clipboard=unnamed
    endif
    vnoremap <special> <D-x> "+x
    vnoremap <special> <D-y> "+y
    cnoremap <special> <D-y> <C-Y>
    nnoremap <special> <D-v> "+gP
    cnoremap <special> <D-v> <C-R>+
endif

" Encoding settings
set ffs=dos,unix
set fileencodings=ucs-bom,utf8,chinese,taiwan,japan,korea
" List invisible chars
set listchars=tab:▸\ ,eol:↲

" Newline style
augroup FileFormat
    au BufWritePre *vimrc,*gvimrc,*.vim,*.sh set ff=unix
augroup END
" Load Windows related settings
if g:is_Win
    source $HOME/vimfiles/mswin.vim
    behave mswin
endif
" Setting current directory
map <silent> <leader>cd :cd %:p:h<cr>
" Theme tweaks
if g:is_Win && &term!="win32"
    set t_Co=256
endif

" Background theme[dark or light]
set bg=light
" Maximum number of characters in a line, used in combination of 'linebreak
"set textwidth=150
" Indentation
set ts=4
set sw=4
" Haskell indent
augroup Haskell
    au!
    au FileType haskell setlocal ts=2 sw=2 | IndentGuidesEnable
augroup END
" C/C++ indentation
augroup C
    au!
    au FileType c,cpp setlocal cindent
augroup END

" Omni completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

set autoindent
" ExpandTab
set et
set smarttab
" Line number
set nu!
" Default directory settings
let &backupdir=expand(vimDir . '/.backups')
let &dir=expand(vimDir . '/.temp')
" Define what characters can be in a word [DO NOT CHANGE!]
set iskeyword=@,48-57,192-255,_
" Wrapping settings
set sbr=
set lbr
set mousemodel=extend
set slm=key,mouse
set fdm=marker
" PEP8
let g:pep8_map='\pep'
" netrw settings
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
" Auto change current directory based on file opened
set acd
"set spr " Split right
" TxtBrowser settings
let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'

augroup NoSpell
    au!
    au FileType txt setlocal ft=txt | setlocal nospell
    au FileType vim setlocal nospell
augroup END

"状态栏设置
"" 始终显示状态栏
set laststatus=2

" Spell check
setlocal spelllang=en_us
"setlocal spell
" 设置Shift-Tab为减少缩进
:imap <S-Tab> 
" 对于绕回显示的行要使用gj,g<Down> 或 gk,g<up> 来跳转到上下行
" 绑定<C-j>,<C-k>,<C-Up>,<C-Down>到以上几个命令
:imap  <C-Up>     <C-o>gk
:imap  <C-Down>   <C-o>gj
:imap  <C-k>      <C-o>gk
:cmap  <C-k>      k
:imap  <C-j>      <C-o>gj
:map   <C-j>      gj
:cmap  <C-j>      j
:map   <C-Down>   gj
:map   <C-k>      gk
:map   <C-Up>     gk
:imap  <C-h>      <C-o>h
:map   <C-h>      h
:map   <C-l>      l
:imap  <C-l>      <C-o>l
" Map M-BS to delete previous word in insert-mode
:imap <M-BS>    <C-w>
" Window commands in insert-mode
:inoremap <C-w>     <C-o><C-w>
" Page up and down in insert-mode
:imap <C-f>     <C-o><C-f>
:imap <C-b>     <C-o><C-b>
" Scroll down and up in insert-mode
:imap <C-e>     <C-o><C-e>
:imap <C-y>     <C-o><C-y>
"Window resize
:nmap <silent> k :res -1<CR>
:nmap <silent> j :res +1<CR>
:nmap <silent> l :vertical res +1<CR>
:nmap <silent> h :vertical res -1<CR>
if g:is_Win
    :nmap <silent> <M-k> :res -1<CR>
    :nmap <silent> <M-j> :res +1<CR>
    :nmap <silent> <M-l> :vertical res +1<CR>
    :nmap <silent> <M-h> :vertical res -1<CR>
endif
" Tab mappings
:nmap <silent> <C-n>n :tabnew<CR>
:nmap <silent> <C-n><C-n> :tabnew<CR>
:nmap <silent> <C-n>e :tabedit %<CR>
:nmap <silent> <C-n><C-e> :tabedit %<CR>
:nmap <silent> <C-n>c :tabclose<CR>
:nmap <silent> <C-n><C-c> :tabclose<CR>
:nmap <silent> <C-n>o :tabonly<CR>
:nmap <silent> <C-n><C-o> :tabonly<CR>
:nmap <silent> <C-n>k :tabnext<CR>
:nmap <silent> <C-n><C-k> :tabnext<CR>
:nmap <silent> <C-n>j :tabprev<CR>
:nmap <silent> <C-n><C-j> :tabprev<CR>
:nmap <silent> <C-n>h :tabfirst<CR>
:nmap <silent> <C-n><C-h> :tabfirst<CR>
:nmap <silent> <C-n>l :tablast<CR>
:nmap <silent> <C-n><C-l> :tablast<CR>
:nmap <silent> <C-n>s :tab split<CR>
:nmap <silent> <C-n><C-s> :tab split<CR>
:nmap <silent> <C-n>v :tab vsplit<CR>
:nmap <silent> <C-n><C-v> :tab vsplit<CR>
:nmap <silent> <C-n>1 :tabnext 1<CR>
:nmap <silent> <C-n>2 :tabnext 2<CR>
:nmap <silent> <C-n>3 :tabnext 3<CR>
:nmap <silent> <C-n>4 :tabnext 4<CR>
:nmap <silent> <C-n>5 :tabnext 5<CR>
:nmap <silent> <C-n>6 :tabnext 6<CR>
:nmap <silent> <C-n>7 :tabnext 7<CR>
:nmap <silent> <C-n>8 :tabnext 8<CR>
:nmap <silent> <C-n>9 :tabnext 9<CR>
:nmap <silent> <C-n>0 :tabnext 10<CR>

"正确的显示 .NFO 文件（ANSI art)
let s:encBackup=&enc
augroup NfoEncoding
    au!
    au BufEnter *.nfo let s:encBackup|set enc=cp437
    au BufLeave *.nfo set enc=s:encBackup
augroup END

" Terminal colors and misc settings
set ttyfast

function s:set_curline_color()
    " Highlight current line and column
    let s:curline_color = {
        \'insert':{
            \'ctermbg':'NONE',
            \'guibg':'NONE'
        \},
        \'normal':{
            \'ctermbg':'NONE',
            \'guibg':'NONE'
            \}
    \}
    if &background=="dark"
        let s:curline_color.insert.ctermbg = 7
        let s:curline_color.insert.guibg = '#003366'
        let s:curline_color.normal.ctermbg = 'NONE'
        let s:curline_color.normal.guibg = 'NONE'
    else
        let s:curline_color.insert.ctermbg = 'lightblue'
        let s:curline_color.insert.guibg = 'lightblue'
        let s:curline_color.normal.ctermbg = 'NONE'
        let s:curline_color.normal.guibg = 'NONE'
    endif

    let s:hi_cursorline_insert_cmd=
                \"highlight CursorLine ctermbg=".s:curline_color.insert.ctermbg
                \." guibg=".s:curline_color.insert.guibg
    let s:hi_cursorline_normal_cmd=
                \"highlight CursorLine ctermbg=".s:curline_color.normal.ctermbg
                \." guibg=".s:curline_color.normal.guibg
    set cursorline
    set cursorcolumn
    augroup CursorLine
        au!
        "au InsertEnter * hi CursorLine ctermbg=black guibg=black
        "au InsertLeave * hi CursorLine ctermbg=17 guibg=#00005f
        au InsertEnter * exe s:hi_cursorline_insert_cmd
        au InsertLeave * exe s:hi_cursorline_normal_cmd
        au WinLeave * setlocal nocursorline nocursorcolumn
        au VimEnter,WinEnter,BufWinEnter * setlocal cursorline cursorcolumn
    augroup END
endfun
" Automatically update curline color after changing coloscheme
au ColorScheme * call s:set_curline_color()

" 版本>7.3,启用新功能
if version>=703
    " 相对行号
    "set rnu
    " Presistent undo
    set undofile
    au BufWritePre /tmp/*,/var/log/* setlocal noundofile
    if g:is_Win
        set undodir=$VIM\\vimfiles\\_undo
    else
        set undodir=~/.vim/.undo
    endif
    " undo次数限制10000
    set ul=10000
    " 高亮textwidth后的第二列
    set colorcolumn=+2
    " 底色为浅绿
    hi colorcolumn guibg=lightgreen
endif
" visualbell
"set visualbell

" 设置不同模式下的光标颜色
if &term =~? "xterm\\|rxvt"
    :silent !echo -ne "\033]12;green\x7"
    let &t_SI = "\033]12;orange\007"
    let &t_EI = "\033]12;green\007"
elseif exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"DoxygenToolkit settings
let g:DoxygenToolkit_authorName="Ryan Feng"
let g:DoxygenToolkit_licenseTag="GPL 2\<enter>"
let g:DoxygenToolkit_undocTag="DOXIGEN_SKIP_BLOCK"
let g:DoxygenToolkit_briefTag_pre = "@brief\t"
let g:DoxygenToolkit_paramTag_pre = "@param\t"
let g:DoxygenToolkit_returnTag = "@return\t"
let g:DoxygenToolkit_briefTag_funcName = "no"
let g:DoxygenToolkit_maxFunctionProtoLines = 30
" ctags and cscope settings
set cscopetag
set tags+=~/.vim/tags
"map <F9> :call Do_CsTag()<CR>
function Do_CsTag() " {{{
    let dir = getcwd()
    if filereadable("tags")
        if(g:is_Win==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:is_Win==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:is_Win==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --python-kinds=-i --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:is_Win!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            silent! execute "cs add cscope.out"
        endif
    endif
endfunction " }}}

" add any database in current directory
if filereadable("cscope.out")
    cs add cscope.out
    " else add database pointed to by environment
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif

" NERDTree settings
nnoremap <F1> :silent! NERDTreeToggle<CR>
inoremap <F1> <C-o>:silent! NERDTreeToggle<CR>

" Quick buf
let g:qb_hotkey = "<F2>"
map <C-w>b <F2>
map <C-w><C-b> <F2>
cmap <C-w>b <F2>
cmap <C-w><C-b> <F2>

" Taglist 设置
"TlistUpdate可以更新tags
noremap <F3> :silent! TagbarToggle<CR>
inoremap <F3> <Esc>:silent! TagbarToggle<CR>
let Tlist_Ctags_Cmd='ctags'
let Tlist_Use_Right_Window=0
let Tlist_Show_One_File=0
let Tlist_File_Fold_Auto_Close=0
let Tlist_Auto_Update=1
let Tlist_Exit_OnlyWindow=1
"是否一直处理tags.1:处理;0:不处理
let Tlist_Process_File_Always=0 "不是一直实时更新tags，因为没有必要
let Tlist_Inc_Winwidth=0
" Gundo(Persistent Undo) 设置
noremap <F4> :GundoToggle<CR>
inoremap <F4> <ESC>:GundoToggle<CR>
" Automatically use opened file instead of reopen in current buf when using quickfix
set switchbuf=useopen
" timeout for mapping(ms)
set timeoutlen=800
" MakeGreen mapping
map <unique> <silent> <Leader>m :call MakeGreen()<CR>
" Tasklist mapping
map <unique> <Leader>l <Plug>TaskList
" Enable neocomplete
let g:neocomplete#enable_at_startup = 1
" neoghc for Haskell completion
let g:necoghc_enable_detailed_browse = 1


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Zen coding
let g:use_zen_complete_tag = 1
let g:user_zen_leader_key = '<c-z>'

" Auto display list chars for some source files
au BufNew,BufEnter,BufNewFile *.h,*.c,*.cpp,*.hpp,*.cxx,
            \*.py,*.hs,*.lhs,*.hsc,*.rb,Makefile,makefile,CMakelists.txt
            \ setlocal list
"Dont miss the space before 'setlocal'

" Highlight extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
augroup HiExtraWhiteSpace
    au ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    au BufWinEnter * match ExtraWhitespace /\s\+$/
    au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    au InsertLeave * match ExtraWhitespace /\s\+$/
    au BufWinLeave * call clearmatches()
augroup END

noremap <Leader><Leader>l :set list!<CR> " toggle list
" Vim indent guides
let g:indent_guides_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
"" Set indent line colors
"augroup IndentGuideColors
    "au VimEnter,ColorScheme * hi IndentGuidesOdd  guibg=#262626 ctermbg=235
    "au VimEnter,ColorScheme * hi IndentGuidesEven guibg=#3a3a3a ctermbg=237
"augroup END

" Auto open and close quickfix window
"augroup Quickfix
    "au QuickFixCmdPost [^l]* nested cwindow 4
    "au QuickFixCmdPost    l* nested lwindow 4
"augroup END

" Session settings
set sessionoptions-=curdir
"" Make compitable with windows, use relative path
set sessionoptions+=slash,unix,sesdir
" map \r to make nerdtree to change cur directory to cur buffer
map <leader>r :NERDTreeFind<cr> " open nerdtree in cur dir
" cpoptinos  snipMate plugin requires B in cpo
"set cpo-=B

" Haskell highligh
let hs_highlight_delimiters = 1
let hs_highlight_boolean = 1
let hs_highlight_types = 1
let hs_highlighy_more_types = 1

" Haskell mode
augroup Haskell
    au FileType haskell compiler ghc
    au FileType haskell let b:ghc_staticoptions = '-Wall -i.:..:../..:../../..:../../../..:../../../../..'
    " Reset makeprg after setting b:ghc_staticoptions
    au FileType haskell execute 'setlocal makeprg=' . g:ghc . '\ ' . escape(b:ghc_staticoptions,' ') .'\ -e\ :q\ %'
    au FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END
if g:is_Mac
    let g:haddock_docdir="/Users/ofan/Library/Haskell/doc"
    let g:haddock_browser="open"
    let g:haddock_browser_callformat = "%s %s"
endif
if g:is_Win
    let g:haddock_browser='$LOCALAPPDATA\Google\Chrome SxS\Application\chrome.exe'
    let g:haddock_docdir='C:\cabal\doc\x86_64-windows-ghc-7.10.1\'
endif

" Syntastic options
let g:syntastic_cpp_check_header = 1
"let g:syntastic_cpp_include_dirs = [ '/usr/include', '/usr/include/c++/4.2.1/', '/opt/local/include', '/usr/local/include', '/opt/local/include/gcc47/c++' ]
"let g:syntastic_cpp_compiler = 'g++'
"let g:syntastic_cpp_compiler_options = '-Wall -std=c++0x'
"let g:syntastic_cpp_config_file = '.syntastic_cpp_config'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" hdevtools options
let g:hdevtools_options = '-g-i.:.. -g-Wall'

" Ctrl-p
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.vim/.cache/ctrlp'
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/]\.(git|hg|svn)$',
            \ 'file': '(\.(DS_Store|so|dll))|\v\.(tmp,exe,dll,so,socket)'
            \ }
let g:ctrlp_lazy_update = 1
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['tag', 'buffertag', 'mixed', 'quickfix', 'dir', 'line']

" Solarized colorscheme
let g:solarized_termcolors=256
let g:solarized_termtrans=1

" YouCompleteMe options
let g:ycm_filetype_whitelist = { 'cpp':1,'c':1, 'python':1 }
let g:ycm_filetype_blacklist = { 'haskell':1 }
let g:ycm_filetype_specific_completion_to_disable = { 'vim':1,'txt':1 }
let g:ycm_confirm_extra_conf = 0
let g:ycm_register_as_syntastic_checker = 1
let g:ycm_global_ycm_extra_conf = expand(vimDir . '/plugin_conf/ycm/.ycm_extra_conf.py')

"" ycm debug
"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'debug'

" Auto-rename tmux window title
let g:in_tmux=$TMUX
if (g:is_Mac || g:is_Linux) && !empty(g:in_tmux) && g:in_tmux != "$TMUX" && !has("gui_running")
    call system("tmux rename-window vim")
    if !exists("$TMUX_WINDOW_TITLE")
        let g:tmux_win_title=system("tmux display-message -p '#W'")
    else
        let g:tmux_win_title=expand("$TMUX_WINDOW_TITLE")
    endif
    augroup TMUX
        autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window ".expand('%'))
        autocmd VimLeave * call system("tmux rename-window -- ".g:tmux_win_title)
    augroup END
endif

" VimShell options
let g:vimshell_editor_command = 'vim'
let g:vimshell_user_prompt = "fnamemodify(getcwd(), ':~')"
let g:vimshell_temporary_directory = expand('~/.vim/.temp')

" Gist settings
if g:is_Mac
    let g:gist_clip_command = 'pbcopy'
    let g:gist_browser_command = 'open %URL%'
endif
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1
let g:gist_show_privates = 1

" jedi-vim settings
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_select_first = 0
let g:jedi#auto_initialization = 1
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = ""

" pymode settings
let g:pymode_rope = 0

" Vimwiki settings
" Stores wiki in dropbox
let dropbox_wiki = {}
if g:is_Mac || g:is_Linux
    let dropbox_wiki.path = "~/Dropbox/VimWiki"
endif
if g:is_Win
    ":echohl "You may need to change the default path of VimWiki"
    let dropbox_wiki.path = expand("%HOMEPATH%\Documents\Dropbox\VimWiki")
endif

if g:is_Cygwin
    let dropbox_wiki.path = "~/Dropbox/Vimwiki"
endif

let dropbox_wiki.html_template = dropbox_wiki.path . "/html_templates/template.tpl"
let dropbox_wiki.nested_syntaxes = {'python': 'python',
\                                   'c++': 'cpp',
\                                   'c': 'c',
\                                   'bash': 'bash',
\                                   'zsh': 'zsh',
\                                   'sh': 'bash',
\                                   'shell': 'bash',
\                                   'haskell': 'haskell'}
let dropbox_wiki.path_html = dropbox_wiki.path . "/html_output"
let dropbox_wiki.template_path = dropbox_wiki.path . "/html_templates"
let dropbox_wiki.template_default = 'default'
let dropbox_wiki.template_ext = '.html'
let dropbox_wiki.css_name = 'css/main.min.css'
let g:vimwiki_list = [dropbox_wiki]

"" Highlight headers with colors
let g:vimwiki_hl_headers = 1
"" Highlight check list items with "Comment" color group
let g:vimwiki_hl_cb_checked = 1
"" Folding
"let g:vimwiki_folding = "syntax"
"" Create page if link is pointing to a directory.
let g:vimwiki_dir_link = 'index'

" Tagbar settings
let g:tagbar_type_vimwiki = {
\ 'ctagstype' : 'vimwiki',
\ 'kinds'     : [
\ 'h:header',
\ ],
\ 'sort'    : 0
\ }

" Airline settings
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_min_count = 1
let g:airline#extensions#tabline#buffer_min_count = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline_theme='simple'
let g:airline_mode_map = {
\ '__' : '-',
\ 'n'  : 'N',
\ 'i'  : 'I',
\ 'R'  : 'R',
\ 'c'  : 'C',
\ 'v'  : 'V',
\ 'V'  : 'V',
\ '' : 'V',
\ 's'  : 'S',
\ 'S'  : 'S',
\ '' : 'S',
\ }

"Easy-align Settings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Supertab settings
let g:SuperTabCrMapping=1

" Emmet settings
let g:user_emmet_install_global = 0
autocmd FileType html,xml,css EmmetInstall

if &t_Co == 256
    colorscheme peaksea
    "colorscheme solarized
else
    colorscheme desert
endif
