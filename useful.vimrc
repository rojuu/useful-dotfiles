" barebone setup without plugins or gui
let mapleader=" "

set nocompatible
set noswapfile

set mouse=a

set backspace=indent,eol,start

set smartcase
set ignorecase

set hidden

set belloff=all

filetype plugin on
syntax on

" reloading buffer when changes done
set autoread
" Reload when focus regained (incase someone from outside changed the file)
" In theory FocusGained only exists for gui
au FocusGained,BufEnter * checktime

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set tabstop=4

set listchars=tab:>\ ,trail:-,nbsp:+
" set listchars=tab:�\ ,trail:�,nbsp:+
" set listchars=tab:»\ ,space:·,trail:·,nbsp:+
" set listchars=tab:>\ ,nbsp:+
" set list
set list
set showbreak=\\
" set showbreak=↪
" would be cool to add '↩' at the end of the line as well
" issue for that in neovim: https://github.com/neovim/neovim/issues/4762

set foldmethod=indent
set foldlevelstart=99

nnoremap <silent><leader>x :%s/\(\s\)\+$//g<CR> ``

nnoremap - :Explore<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

nnoremap <silent>j gj
nnoremap <silent>k gk
vnoremap <silent>j gj
vnoremap <silent>k gk

nnoremap <leader>v <C-W><C-V><C-W><C-L>
nnoremap <leader>q <C-W><C-Q>

nnoremap <silent><leader>cn :cnext<CR>
nnoremap <silent><leader>cp :cprev<CR>
nnoremap <silent><leader>cq :cclose<CR>
nnoremap <silent><leader>cw :cwindow<CR>

vnoremap <silent>< <gv
vnoremap <silent>> >gv

vnoremap <silent><TAB> >gv
vnoremap <silent><S-TAB> <gv

nnoremap <silent><leader>w :w<CR>

" C-] is quite hard to use on nordic kb layout, so rebind that
nnoremap <leader>tt <C-]>

" yank current file full path to system clipboard
noremap <silent><leader>yf :let @+ = expand("%:p")<CR>
" yank current file relative path to system clipboard
nnoremap <silent><leader>yr :let @+ = expand("%")<CR>

" nvim specifics
if has('nvim')
  " for some reason this breaks on vanilla vim?
  nnoremap <silent><ESC> :nohls<CR>:cclose<CR>
  tnoremap <Esc> <C-\><C-n>
endif
