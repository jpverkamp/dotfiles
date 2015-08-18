<<<<<<< HEAD
# Fix arrow keys when logged into remote machines
set nocompatible

# Automatically reload files changed on disk
set autoread

# :W will save the file even if you forgot to open it with sudo
command W w !sudo tee % > /dev/null

# If we can figure out what a mouse is, go ahead and enabled it
=======
" Allow configuration based on filetype
filetype on

" Fix arrow keys when logged into remote machines
set nocompatible

" Automatically reload files changed on disk
set autoread

" :W will save the file even if you forgot to open it with sudo
command W w !sudo tee % > /dev/null

" If we can figure out what a mouse is, go ahead and enabled it
>>>>>>> 3ec0c48e338ee81a5853b71d1863659106a02df1
if has('mouse')
  set mouse=a
endif

<<<<<<< HEAD
# Highlight all search results, not just the next; search as you type
set hlsearch
set incsearch 

# I've never actually used the VIM backup files... Use version control
set nobackup
set nowb
set noswapfile
=======
" Highlight all search results, not just the next; search as you type
set hlsearch
set incsearch 

" I've never actually used the VIM backup files... Use version control
set nobackup
set nowb
set noswapfile

" Highlight overly long commit messages
au FileType gitcommit set tw=72 | set spell | set colorcolumn=50
>>>>>>> 3ec0c48e338ee81a5853b71d1863659106a02df1
