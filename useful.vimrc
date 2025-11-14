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


" Adding syntax definitions can be done similar to this:
" clone the language syntax plugin somwhere e.g. ~/.vim/plugins/foo-lang-syntax
" Then add these to .vimrc:
" set rtp+=~/.vim/plugins/foo-lang-syntax
" autocmd BufNewFile,BufRead *.foo :set filetype=foo

" To print out the highight groups of whatever is below the cursor
function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map gm :call SynStack()<CR>
