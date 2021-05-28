set expandtab
set softtabstop=2
set shiftwidth=2
set autoindent
filetype plugin indent on
syntax on

" Enable search highlighting and incremental searching
set incsearch
set hlsearch
" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Save as sudo with :w!!
cmap w!! w !sudo tee > /dev/null %

" Enable markdown folding, start wtih all folds expanded
let g:markdown_folding = 1
au FileType markdown setlocal foldlevel=99
