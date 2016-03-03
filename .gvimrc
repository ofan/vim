" 模拟windows下的一些设置
if g:is_Win
    source $HOME/vimfiles/mswin.vim
else
    source ~/.vim/mswin.vim
endif

" Window resize
if g:is_Mac
    " Alt+hjkl is converted to special charaters under MacVim
    :nmap <silent> ˚ :res +1<CR>
    :nmap <silent> ∆ :res -1<CR>
    :nmap <silent> ¬ :vertical res +1<CR>
    :nmap <silent> ˙ :vertical res -1<CR>
endif

" Toggle Toolbar
set guioptions-=T
set guioptions-=m

" No scroll bar
set go-=L
set go-=R
set go-=r

"map <silent> <F2> :if &guioptions =~# 'T' <Bar>
		"\set guioptions-=T <Bar>
	"\else <Bar>
		"\set guioptions+=T <Bar>
	"\endif<CR><CR>
"map <silent> <F3> :if &guioptions =~# 'm' <bar>
		"\set guioptions-=m <bar>
	"\else <Bar>
		"\set guioptions+=m <bar>
	"\endif<CR><CR>
"=========================== gvimrc_example =========================
" An example for a gvimrc file.
" The commands in this are executed when the GUI is started.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2001 Sep 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.gvimrc
"	      for Amiga:  s:.gvimrc
"  for MS-DOS and Win32:  $VIM\_gvimrc
"	    for OpenVMS:  sys$login:.gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

set ch=1		" Make command line two lines high

set mousehide		" Hide the mouse when typing text
"字体设置
if g:is_Win
    "set gfn=Megatops_ProCoder_1.0:h10:b:cANSI
    "set gfn=Ubuntu_Mono_derivative_Powerlin:h11:cANSI
    "set gfn=DejaVu_Sans_Mono_for_Powerline_:h10:cANSI
    set gfn=Meslo_LG_S_for_Powerline_PNFT_P:h10:cANSI
    set gfw=NSimSun:h11:cANSI
elseif g:is_Mac
    "set gfn=Consolas:h12
    "set gfn=Consolas\ for\ Powerline:h12
    set gfn=Menlo\ Regular\ for\ Powerline:h11
    set gfw=Microsoft\ YaHei
else
    "set gfn=Megatops\ ProCoder\ 1.0\ Bold\ 9
    set gfn=Terminus\ 9
    set gfw=最像素EX2\ 10
endif

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif
endif

" Set transparency
if has("transparency")
  set transparency=4
endif

" Colorscheme
"colorscheme solarized
colorscheme xcode-dusk
