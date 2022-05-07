let mapleader = " "
"----------- SETTING OPTIONS ----------
set relativenumber
set number
set numberwidth=4
set nohlsearch
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set shiftround
set nowrap
set incsearch
set scrolloff=20
"set signcolumn=yes
set showmode
set showcmd
set ruler
set wrap
set mps+=<:>
filetype plugin indent on
"----------- GENERAL MAPPINGS ------------
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"------------ PLUGINS
call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


call plug#end()
