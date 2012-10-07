" vim: ts=4 sw=4
"{{{= vimrc_example =========================================
" An example for a vimrc file.
"
" Maintainer: Bram Moolenaar <Bram@vim.org>
" Last change: 2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

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

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
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
    call pathogen#runtime_append_all_bundles()

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

"= vimrc_example======================================================}}}
" Customized settings
"
" Determine platform
let g:is_Win = 0
let g:is_Mac = 0
let g:is_Linux = 0

if has("win32") || has("win64") || has("win32unix")
    let g:is_Win=1
else
    if has("mac") || has("macunix")
        let g:is_Mac=1
    else
        let g:is_Win = 0
        let g:is_Linux = 1
    endif
endif

" 剪切板设置
if g:is_Mac
    "if has("clipboard")
        "set clipboard=unnamed
    "endif
    vnoremap <special> <D-x> "+x
    vnoremap <special> <D-y> "+y
    cnoremap <special> <D-y> <C-Y>
    nnoremap <special> <D-v> "+gP
    cnoremap <special> <D-v> <C-R>+
endif

" 编码设置
set ffs=dos,unix
set fileencodings=ucs-bom,utf8,chinese,taiwan,japan,korea
if g:is_Win
    set termencoding=gbk
else
    set termencoding=utf8
endif
" 写入配置文件和脚本插件时强制使用unix风格换行
au BufWritePre *vimrc,*gvimrc,*.vim set ff=unix
" 不兼容Vi
set nocompatible
if g:is_Win
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif
" 文件名设置
set isf=@,48-57,.,-,_,+,$,%,~
" 设置当前工作路径
map <silent> <leader>cd :cd %:p:h<cr>
" 颜色和配色方案
if g:is_Win && &term!="win32"
    set t_Co=256
endif
set bg=dark
" 设置最长文本长度，超过此长度会被自动截断
"set textwidth=150
" 缩进
set ts=4
set sw=4
" C语言缩进
au BufNew,BufRead *.h,*.cpp,*.c,*.hpp,*.cxx setlocal cindent
" 自动缩进
set autoindent
" 使用空格替换Tab
set et
" 智能Tab,按退格删除4个空格
set smarttab
" 行号
set nu!
" 设置目录
if g:is_Win
    set backupdir=D:\\Temp\\_vim_backups
    set dir=D:\\Temp
else
    set backupdir=~/.vim/.backups
    set dir=~/.vim/.temp
endif
" 帮助
if version >= 603
    set helplang=cn
endif
" 设置word所能包含的字符
set iskeyword=@,48-57,192-255,_
" 折行设置
set sbr=
set lbr
set mousemodel=extend
set slm=key,mouse
set fdm=marker
" PEP8
let g:pep8_map='\pep'
" netrw 设置
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
" 自动变更当前目录到打开文件的目录
set acd
" 分割窗口设置
"set spr " 分割窗口从右边打开.
" TxtBrowser设置
let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'
au BufNewFile,BufRead *.txt setlocal ft=txt | setlocal nospell
" C++ Support Support
"map <C-M-r> @='<Leader>rc|<Leader>rl|<Leader>rr'<CR>
"状态栏设置
"" 始终显示状态栏
set laststatus=2
"" {{{ Statusline
"let statusHead        ="%-.50f\ %h%m%r"
"let statusBreakPoint  ="%<"
"let statusSeparator   ="|"
"let statusFileType    ="%{((&ft\ ==\ \"help\"\ \|\|\ &ft\ ==\ \"\")?\"\":\"[\".&ft.\"]\")}"
"let statusFileFormat  ="[%{(&ff\ ==\ \"unix\")?\"u\":\"d\"}]"
"let statusAscii       ="\{%b:0x%B\}"
"let statusCwd         ="%-.50{getcwd()}"
"let statusBody        =statusFileType.statusFileFormat.statusSeparator.statusAscii.statusSeparator."\ ".statusBreakPoint.statusCwd
"let statusEncoding    ="[%{(&fenc\ ==\ \"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]"
"let statusBlank       ="%="
"let statusKeymap      ="%k"
"let statusRuler       ="%-12.(%lL,%c%VC%)\ %P"
"let statusTime        ="%{strftime(\"%y-%m-%d\",getftime(expand(\"%\")))}"
"let statusEnd         =statusKeymap."\ ".statusEncoding.statusRuler."\ ".statusTime
""" 最终状态栏的模式字符串
"let statusString=statusHead.statusBody.statusBlank.statusEnd
""" 恢复statusLine的状态(gdbmgr会修改statusline)
"function! ResetStatusline()
    "set statusline=%!statusString
"endfunction
"call ResetStatusline()
" }}}

" Spell check
setlocal spelllang=en_us
"setlocal spell
" 设置Shift-Tab为减少缩进
:imap <S-Tab> 
" 对于绕回显示的行要使用gj,g<Down> 或 gk,g<up> 来跳转到上下行
" 绑定<C-j>,<C-k>,<C-Up>,<C-Down>到以上几个命令
:imap  <C-Up>     <C-o>gk
:imap  <C-k>      <C-Up>
:imap  <C-Down>   <C-o>gj
:imap  <C-j>      <C-Down>
:map   <C-j>      gj
:map   <C-Down>   gj
:map   <C-k>      gk
:map   <C-Up>     gk
:imap  <C-h>      <C-o>h
:map   <C-h>      h
:map   <C-l>      l
:imap  <C-l>      <Right>
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
:nmap <silent> k :res +1<CR>
:nmap <silent> j :res -1<CR>
:nmap <silent> l :vertical res +1<CR>
:nmap <silent> h :vertical res -1<CR>
"正确的显示 .NFO 文件（ANSI art)
"let s:encBackup=&enc
au BufEnter *.nfo let s:encBackup|set enc=cp437
au BufLeave *.nfo set enc=s:encBackup
" 终端设置
set ttyfast
" 载入Pyclewn
"runtime pyclewn.vim

" 高亮当前行
set cursorline
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
" 设定Alt+Backspace为ESC键
"noremap! <M-BS> <ESC>
"vnoremap <M-BS> <ESC>
"snoremap <M-BS> <ESC>
"lnoremap <M-BS> <ESC>
"inoremap <M-BS> <ESC>
" Txt2tags 文件
au BufNewFile,BufRead *.t2t,*.t,*.tt setf txt2tags
" visualbell
"set visualbell
" 打开光标下的文件
"" for Windows
vnoremap <silent> <C-F5> :<C-U>let old_reg=@"<CR>gvy:silent!!cmd /cstart <C-R><C-R>"<CR><CR>:let @"=old_reg<CR>
"
" 设置perl-support的工作目录
let g:Perl_Support_Root_Dir = expand("$HOME")."/.vim/bundle"
" 设置不同模式下的光标颜色
if &term =~? "xterm\\|rxvt"
    :silent !echo -ne "\033]12;green\x7"
    let &t_SI = "\033]12;orange\007"
    let &t_EI = "\033]12;green\007"
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
map <F9> :call Do_CsTag()<CR>
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
noremap <F3> :silent! NERDTreeToggle<CR>

" Quick buf

" Taglist 设置
"TlistUpdate可以更新tags
noremap <F5> :silent! TagbarToggle<CR>
inoremap <F5> <Esc>:silent! TagbarToggle<CR>
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
noremap <F6> :GundoToggle<CR>
inoremap <F6> <ESC>:GundoToggle<CR>
" Automatically use opened file instead of reopen in current buf when using quickfix
set switchbuf=useopen
" timeout for mapping(ms)
set timeoutlen=800
" MakeGreen mapping
map <unique> <silent> <Leader>m :call MakeGreen()<CR>
" Tasklist mapping
map <unique> <Leader>l <Plug>TaskList
" ChangesPlugin settings
let g:changes_autocmd=0 " Auto-refresh the changes
let g:changes_verbose=0
" Enable neocomplcache
"let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_at_startup = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Zen coding
let g:use_zen_complete_tag = 1
let g:user_zen_leader_key = '<c-;>'

" List invisible chars
set listchars=tab:▸\ ,eol:¬
" Auto display list chars for some source files
au BufNew,BufEnter *.h,*.c,*.cpp,*.hpp,*.cxx,
            \*.py,*.hs,*.rb,Makefile,makefile,CMakelists.txt
            \ setlocal list
"Dont miss the space before 'setlocal'

" Highlight extra whitespace
au ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

noremap <Leader><Leader>l :set list!<CR>
" Vim indent guides
hi IndentGuidesOdd  ctermbg=white
hi IndentGuidesEven ctermbg=lightgrey
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" Powerline
if has("gui_running")
    let g:Powerline_symbols = 'fancy'
endif

" Session settings
set sessionoptions-=curdir
"" Make compitable with windows, use relative path
set sessionoptions+=slash,unix,sesdir
" map \r to make nerdtree to change cur directory to cur buffer
map <leader>r :NERDTreeFind<cr>
" cpoptinos  snipMate plugin requires B in cpo
"set cpo-=B
" colorscheme peaksea
colorscheme gentooish
