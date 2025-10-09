syntax on
set nocompatible
let mapleader=' '
nnoremap <leader>v <C-W><C-V><C-W><C-W>
nnoremap <leader>s <C-W><C-S><C-W><C-W>
nnoremap <leader>q <C-W><C-Q>

nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

set noswapfile
set nobackup nowritebackup

set ignorecase
set smartcase
set incsearch

" Sometimes the default regex engine breaks for some files and makes the editor freeze
" Setting the regexpengine to 2 e.g. the new NFA engine will fix it.
set regexpengine=2
