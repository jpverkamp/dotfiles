" Fix arrow keys when logged into remote machines
set nocompatible

" Automatically reload files changed on disk
set autoread

" If we can figure out what a mouse is, go ahead and enabled it
if has('mouse')
  set mouse=a
endif

" Highlight all search results, not just the next; search as you type
set hlsearch
set incsearch 

" I've never actually used the VIM backup files... Use version control
set nobackup
set nowb
set noswapfile
