set nu

set autoindent
set noexpandtab
set tabstop=8
set shiftwidth=8

syntax on

highlight LineNr ctermfg=gray
highlight StatusLine ctermfg=blue
highlight StatusLine ctermbg=black

highlight ColorColumn ctermbg=gray
call matchadd('ColorColumn', '\%81v', 100)

highlight Trailing ctermbg=gray
call matchadd('Trailing', '\s\+$')
call matchadd('Trailing', ' \+\ze\t')
call matchadd('Trailing', '$       ')

set laststatus=2

set timeoutlen=1000 ttimeoutlen=0
