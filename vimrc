set nocompatible
filetype off

" Execute Vundle if it exists
if !empty(glob("~/.vim/bundle/Vundle.vim"))
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

	Plugin 'VundleVim/Vundle.vim'

	" Execute ~/.vim/vundlerc if it exists
	if !empty(glob("~/.vim/vundlerc"))
		" Put plugins in ~/.vim/vundlerc
		source ~/.vim/vundlerc
	endif

	call vundle#end()
endif

filetype plugin indent on

set nu
set hlsearch
set autoindent
set t_Co=256  " 256 Colors
set spell spelllang=en
set popt+=formfeed:y
"set nosmartindent
"set softtabstop=0

highlight LineNr ctermfg=gray
highlight StatusLine ctermfg=blue
highlight StatusLine ctermbg=black

" Highlight lines that exceed 80 columns
highlight ColorColumn ctermbg=gray
augroup ColorColumn
	au!
	au VimEnter,WinEnter * call matchadd('ColorColumn', '\%81v', 100)
augroup END

" Highlight lines that have bad spaces
highlight Trailing ctermbg=gray
augroup Trailing
	au!
	au VimEnter,WinEnter * call matchadd('Trailing', '\s\+$')    " Trailing spaces
	au VimEnter,WinEnter * call matchadd('Trailing', ' \+\ze\t') " Spaces before a tab
augroup END

if has("gui_running")
	colors electromatter
	set guifont=DejaVu\ Sans\ Mono\ Book\ 9
	set noeb vb t_vb=
	set guioptions=
	set guicursor=a:blinkon0,a:block
	set belloff=all
endif
