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

" Don't source menu.vim (slow)
set guioptions+=M

" Script encoding
scriptencoding utf-8

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'
" Default directory paths
let g:dir_vimhome = win_shell ? '$HOME/vimfiles' : '$HOME/.vim'
let g:dir_projhome = $PROJECT_HOME ? $PROJECT_HOME : '$HOME/Projects'
let g:dir_utilsbin = $VIM_UTILS_BIN ? $VIM_UTILS_BIN : '$VIM/utils/bin'
let g:dir_path_separator = (g:is_Win ? ';' : ':')
let $PATH = $PATH . g:dir_path_separator . expand(g:dir_utilsbin)

if g:is_Win
    set shellxescape-=\>
    set shellxescape-=\&
endif

call plug#begin(expand(g:dir_vimhome . '/plugged'))
" {{{ Plugins
" {{{ UI extensions
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify' " Fancy startscreen
Plug 'Xuyuanp/nerdtree-git-plugin'
" }}}
" {{{ File types and highlighting
Plug 'chrisbra/csv.vim', {'for' : 'csv'}
Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'klen/python-mode', {'for' : 'python'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'reinh/vim-makegreen', {'on' : 'MakeGreen'} " Highlight compiler/tests output
" {{{ Project management
Plug 'dbakker/vim-projectroot'
" }}}}
" Haskell plugins
if !g:is_Win
    Plug 'Twinside/vim-haskellConceal'
endif
Plug 'Twinside/vim-haskellFold', {'for': 'haskell'}
Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}
Plug 'wlangstroth/vim-haskell', {'for': 'haskell'}
" }}}
" {{{ Productivity
Plug 'chrisbra/NrrwRgn'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdcommenter' " Toggle comments for various file types
Plug 'mattn/emmet-vim', {'for': ['html', 'xml', 'css']} " Generate tags based on rules
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'terryma/vim-multiple-cursors'
" }}}
" {{{ Integration
Plug 'fs111/pydoc.vim', {'for': 'python'}
Plug 'alfredodeza/pytest.vim', {'for': 'python'}
Plug 'Shougo/vimproc' | Plug 'ujihisa/repl.vim'
Plug 'tpope/vim-git'
Plug 'motemen/git-vim'
Plug 'scrooloose/syntastic'
Plug 'rhysd/vim-clang-format', {'for': ['c', 'cpp']}
Plug 'airblade/vim-gitgutter', {'on': ['GitGutterToggle', 'GitGutterEnable']}
Plug 'Shougo/vimshell'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'tsukkee/unite-tag'
Plug 'Shougo/unite-outline'
Plug 'ujihisa/unite-colorscheme'
if g:is_Win
Plug 'sgur/unite-everything'
endif
Plug 'tacroe/unite-mark'
Plug 'tacroe/unite-alias'
Plug 'sgur/unite-qf' " Quickfix source

Plug 'tpope/vim-fugitive'
Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
Plug 'mattn/gist-vim' " Github gist
" }}}
" {{{ Themes or decorators
Plug 'altercation/vim-colors-solarized'
Plug 'stephenmckinney/vim-solarized-powerline'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" }}}
" {{{ Completion
Plug 'ervandew/supertab'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'Shougo/neocomplete.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Townk/vim-autoclose'
Plug 'Rip-Rip/clang_complete'
" }}}
" {{{ Text editing
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
" }}}
" {{{ Misc
" Misc or dependencies
Plug 'mattn/webapi-vim'
" }}}
" {{{ Plugins from vim-scripts
Plug 'TaskList.vim'
Plug 'vimwiki'
Plug 'VOoM'
"Plug 'FuzzyFinder'
Plug 'DoxygenToolkit.vim'
Plug 'L9'
Plug 'dbext.vim'
"Plug 'QuickBuf'
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
set list
" Toggle listchars
noremap <Leader><Leader>l :set list!<CR>

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
let &backupdir=expand(g:dir_vimhome . '/.backups')
let &dir=expand(g:dir_vimhome . '/.temp')
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
" set autochdir
"set spr " Split right
" TxtBrowser settings
let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'

augroup NoSpell
    au!
    au FileType txt setlocal ft=txt | setlocal nospell
    au FileType vim setlocal nospell
augroup END

" Status bar settings
set laststatus=2

" Spell check
setlocal spelllang=en_us
"setlocal spell
" Shift-Tab un-tab
:imap <S-Tab> 
" Cursor movement in insert mode
" For wrapped lines, use gj,g<Down> or gk,g<up> to jump between lines
" Map <C-j>,<C-k>,<C-Up>,<C-Down>
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
:nmap <silent> <C-n>j :tabnext<CR>
:nmap <silent> <C-n><C-j> :tabnext<CR>
:nmap <silent> <C-n>k :tabprev<CR>
:nmap <silent> <C-n><C-k> :tabprev<CR>
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

".NFO files (ANSI art)
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
        let s:curline_color.insert.ctermbg = 24
        let s:curline_color.insert.guibg = '#003366'
        let s:curline_color.normal.ctermbg = 8
        let s:curline_color.normal.guibg = 'NONE'
    else
        let s:curline_color.insert.ctermbg = 'lightblue'
        let s:curline_color.insert.guibg = 'lightblue'
        let s:curline_color.normal.ctermbg = 'lightyellow'
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
        "au InsertEnter * hi CursorLine ctermbg=black guibg='NONE'
        "au InsertLeave * hi CursorLine ctermbg=17 guibg=#00005f
        au InsertEnter * exe s:hi_cursorline_insert_cmd
        au InsertLeave * exe s:hi_cursorline_normal_cmd
        au WinLeave * setlocal nocursorline nocursorcolumn
        au VimEnter,WinEnter,BufWinEnter * setlocal cursorline cursorcolumn
    augroup END
endfun
" Automatically update curline color after changing coloscheme
au ColorScheme * call s:set_curline_color()

if version>=703
    " Presistent undo
    set undofile
    au BufWritePre /tmp/*,/var/log/* setlocal noundofile
    if g:is_Win
        set undodir=$VIM\\vimfiles\\_undo
    else
        set undodir=~/.vim/.undo
    endif
    " undo limit 10000
    set ul=10000
    " Highlight column textwidth+2
    set colorcolumn=+2
endif
" visualbell
"set visualbell

" Set cursor color
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

" add any database in current directory
if filereadable(".cscope.out")
    cs add cscope.out
    " else add database pointed to by environment
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif

" NERDTree settings
nnoremap <silent> <F1> :NERDTreeToggle<CR>
inoremap <silent> <F1> <C-o>:NERDTreeToggle<CR>
" map \r to make nerdtree to change cur directory to cur buffer
map <leader>r :NERDTreeFind<cr> " open nerdtree in cur dir

" NERDTree-git settings
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" Unite settings
let g:unite_data_directory = expand(g:dir_vimhome . '/.cache/unite')

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#profile('default',
          \ 'context', {
          \   'smartcase': 1,
          \   'start_insert': 1,
          \   'winheight': 10,
          \   'direction': 'botright',
          \ })
nnoremap <silent> <F2> :<C-u>Unite<CR>
inoremap <silent> <F2> <C-o>:<C-u>Unite<CR>

nnoremap [unite] <Nop>
nmap <leader>u [unite]
nnoremap <silent> [unite]f :<C-u>Unite file<CR>
nnoremap <silent> [unite]fr :<C-u>Unite file_rec/async:!<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
nnoremap <silent> [unite]s :<C-u>Unite source<CR>
nnoremap <silent> [unite]m :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer bookmark<CR>
nnoremap <silent> [unite]e :<C-u>Unite -buffer-name=everything everything<CR>
nnoremap <silent> [unite]r :<C-u>UniteResume<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Overwrite settings.

  imap <buffer><expr> j unite#smart_map('j', '')
  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  imap <buffer> <C-Backspace>     <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  imap <buffer> <C-x>     <Plug>(unite_quick_match_jump)
  nmap <buffer> <C-x>     <Plug>(unite_quick_match_jump)
  imap <buffer> <C-v>     <Plug>(unite_toggle_auto_preview)
  nmap <buffer> <C-v>     <Plug>(unite_toggle_auto_preview)
  nmap <buffer> <C-h>     <Plug>(unite_quick_help)
  " Runs "split" action by <C-s>.
  imap <silent><buffer><expr> <C-s>     unite#do_action('split')
endfunction

" Unite everything source settings
let g:unite_source_everything_cmd_path = 'es.exe'
let g:unite_source_everything_posix_regexp_search = 1

" Startify settings
let g:startify_list_order = [
            \ ['    Most recently used files in the current directory'],
            \ 'dir',
            \ ['    Most recently used files'],
            \ 'files',
            \ ['    Bookmarks'],
            \ 'bookmarks',
            \ ['    Sessions'],
            \ 'sessions',
            \ ]
let g:startify_bookmarks = [
            \ {'v': expand(g:dir_vimhome . '/vimrc')},
            \ {'h': expand('$HOME' . '/')},
            \ {'p': expand(g:dir_projhome . '/')},
            \ ]
let g:startify_skiplist = [
    \ 'COMMIT_EDITMSG',
    \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
    \ 'plugged[/\\].*[/\\]doc',
    \ '.git[/\\].*',
    \ ]
let g:startify_custom_header = [
\'                           ╓─╖╓──╖ ╓─╖ ╓────╖ ╓────╖',
\'                           ║░║║░╓╜ ║░║ ║░╓──╜ ║░╓──╜',
\'                           ║░╙╜╓╜░ ║░║ ║░╙──╖ ║░╙──╖',
\'                           ║░╓╖╙╖░ ║░║ ╙──╖░║ ╙──╖░║',
\'                           ║░║║░╙╖ ║░║ ╓──╜░║ ╓──╜░║',
\'                           ╙─╜╙──╜ ╙─╜ ╙────╜ ╙────╜',
\'',
\'',
\]
let g:startify_files_number = 5
let g:startify_session_autoload = 0
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1

" GutenTags settings


" Gundo(Persistent Undo) settings
noremap <F4> :GundoToggle<CR>
inoremap <F4> <ESC>:GundoToggle<CR>
" Automatically use opened file instead of reopen in current buf when using quickfix
set switchbuf=useopen
" Timeout for mapping(ms)
set timeoutlen=600
" MakeGreen mapping
map <unique> <silent> <Leader>m :MakeGreen<CR>
" Tasklist mapping
map <unique> <Leader>l <Plug>TaskList
" neoghc for Haskell completion
let g:necoghc_enable_detailed_browse = 1
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Use VimCompletesMe for <Tab> mappings(fuck off supertab, fuck off
" neocomplete, fuck off ultisnips!)
let g:vcm_default_maps = 1

" Use neocomplete.
" neocomplete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" increase limit for tag cache files
let g:neocomplete#sources#tags#cache_limit_size = 16777216 " 16MB

" fuzzy completion breaks dot-repeat more noticeably
" https://github.com/Shougo/neocomplete.vim/issues/332
let g:neocomplete#enable_fuzzy_completion = 0

" always use completions from all buffers
if !exists('g:neocomplete#same_filetypes')
  let g:neocomplete#same_filetypes = {}
endif
let g:neocomplete#same_filetypes._ = '_'

" from neocomplete.txt:
" ---------------------

" Plugin key-mappings.
inoremap <expr> <C-g> neocomplete#undo_completion()

" Recommended key-mappings.
" <CR>: cancel popup and insert newline.
inoremap <silent> <CR> <C-r>=neocomplete#smart_close_popup()<CR>
" <TAB>: completion.
inoremap <expr> <Tab> pumvisible() ? "\<C-;>" : "\<Tab>"
inoremap <expr> <BS>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr> <C-;> neocomplete#close_popup()
inoremap <expr> <C-'> neocomplete#cancel_popup()
"}}}

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

" Vim indent guides
let g:indent_guides_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
" Auto open and close quickfix window
"augroup Quickfix
    "au QuickFixCmdPost [^l]* nested cwindow 4
    "au QuickFixCmdPost    l* nested lwindow 4
"augroup END

" Session settings
set sessionoptions-=curdir
"" Make compitable with windows, use relative path
set sessionoptions+=slash,unix,sesdir
" Haskell highligh
let hs_highlight_delimiters = 1
let hs_highlight_boolean = 1
let hs_highlight_types = 1
let hs_highlighy_more_types = 1

" Syntastic options
let g:syntastic_cpp_check_header = 1
let g:syntastic_enable_cpp_checker = 1
let g:syntastic_cpp_checkers = ['clang_check']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_filetype_map = {}
let g:syntastic_clang_check_config_file = ".clang_complete"
let g:syntastic_clang_tidy_config_file = ".clang_complete"
let g:syntastic_cpp_clang_check_post_args = '-p compile_commands.json'
let g:syntastic_cpp_clang_tidy_post_args = '-p compile_commands.json'

" hdevtools options
let g:hdevtools_options = '-g-i.:.. -g-Wall'

" Solarized colorscheme
let g:solarized_termcolors=256
let g:solarized_termtrans=1

" Clang-format settings
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup"}

" Clang complete settings
let g:clang_snippets = 1
let g:clang_snippets_engine = 'ultisnips'
let g:clang_complete_macros = 1
let g:clang_use_library = 1
let g:clang_auto_user_options = "compile_commands.json, .clang_complete, path"
nnoremap <C-c><C-f> :call g:ClangUpdateQuickFix()
inoremap <C-c><C-f> <C-o>:call g:ClangUpdateQuickFix()

" UltiSnips settings
let g:UltiSnipsUsePythonVersion=3
let g:UltiSnipsJumpForwardTrigger='<C-n>'
let g:UltiSnipsJumpBackwardTrigger='<C-p>'

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
let g:vimshell_temporary_directory = expand(g:dir_vimhome . '/.temp')
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
if g:is_Mac || g:is_Linux || g:is_Cygwin
    let dropbox_wiki.path = "~/Dropbox/VimWiki"
endif
if g:is_Win
    ":echohl "You may need to change the default path of VimWiki"
    let dropbox_wiki.path = expand("%HOMEPATH%\Documents\Dropbox\VimWiki")
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
nnoremap <silent> <F3> :TagbarToggle<CR>
inoremap <silent> <F3> <C-o>:TagbarToggle<CR>
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
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 0
let g:airline#extensions#nrrwrgn#enabled = 1
let g:airline_theme='sol'

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

" Webdevicons settings
let g:webdevicons_enable = 1
let g:webdevicons_enable_unite = 1
let g:webdevicons_enable_nerdtree = 1

"Easy-align Settings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Supertab settings
let g:SuperTabCrMapping=1
let g:SuperTabDefaultCompletionType = "<c-n>"

" Emmet settings
let g:user_emmet_install_global = 0
autocmd FileType html,xml,css EmmetInstall

" Multi cursor settings
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-n>'
let g:multi_cursor_skip_key='<C-o>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-m>'
let g:multi_cursor_start_word_key='g<C-m>'
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

let g:gutentags_ctags_no_space_in_paths = 0

" Auto load .proj_vim
" .proj.vim is a vim script that will be executed when openning a file,
" it may or may not change default settings set in .[g]vimrc
let g:project_root_path = projectroot#get()
let g:project_loaded_proj_vim = {}
function LoadProjVim()
    let s:proj_vim = expand(g:project_root_path . '/.proj.vim')
    if !get(g:project_loaded_proj_vim, s:proj_vim) && filereadable(s:proj_vim)
        exec 'source ' . s:proj_vim
        let g:project_loaded_proj_vim[s:proj_vim] = 1
    endif
endfunction
call LoadProjVim()

if &t_Co == 256
    colorscheme peaksea
    set bg=dark
else
    colorscheme relaxedgreen
    set bg=dark
endif
