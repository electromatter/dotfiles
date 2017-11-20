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
"set nosmartindent
"set softtabstop=0

highlight LineNr ctermfg=gray
highlight StatusLine ctermfg=blue
highlight StatusLine ctermbg=black

" Highlight lines that exceed 80 columns
highlight ColorColumn ctermbg=gray
call matchadd('ColorColumn', '\%81v', 100)

" Highlight lines that have bad spaces
highlight Trailing ctermbg=gray
call matchadd('Trailing', '\s\+$')    " Trailing spaces
call matchadd('Trailing', ' \+\ze\t') " Spaces before a tab
