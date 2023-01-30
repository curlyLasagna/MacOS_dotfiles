" {{{ Keymaps
" Alternative tab navigation
nnoremap tl :tabnext<CR>
nnoremap th :tabprevious<CR>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <c-p> :Files<cr>
" Leader key combos
" Yank to system clipboard
nnoremap <leader>y :"+y
" Save file
nnoremap <leader>w :w<Return>
" Quit
nnoremap <leader>q :q<Return>
" Save & quit
nnoremap <leader>wq :x<Return>
" Toggle NERDTree
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" save files as root
noremap <leader>W :w !sudo tee % > /dev/null
" }}}

" Maintains VisualMode after indenting with < or >
vmap < <gv
vmap > >gv

" Set leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" Leader timeout length
set timeoutlen=2000

" {{{ User config
" Line numbers
set number
set numberwidth=4
highlight VertSplit ctermbg=6 ctermfg=0

set completeopt=longest,menuone

" Enable syntax highlighting
syntax on
" Set non-text characters to background color
" :hi EndOfBuffer ctermbg=black ctermfg=black

set relativenumber
" Continous line for vertical splits
set fillchars+=vert:\▏ 

" Use system clipboard
set clipboard=unnamedplus

" Color scheme
colorscheme default

" Mouse emulation within vim 
set mouse=a

set smartcase
set ignorecase

" Tabbing options
set sw=2 ts=2 sts=2 sta et 

set noswapfile
set ruler
" Use a space, not two after punctuation
set nojoinspaces

" Cursor jumps to the matching brace when inserted
set showmatch

" Vim-Terminal configuration
set termwinsize=20*0

" Save and restore folds
augroup rcFold
  au BufWinLeave .vimrc mkview
  au BufWinEnter .vimrc silent loadview
  au FileType vim,txt setlocal foldmethod=marker
augroup END

" New split panes start at the bottom or to the right.
set splitbelow splitright
" }}}
