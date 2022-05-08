let mapleader = " "
let g:netrw_liststyle = 3 "use tree display
let g:netrw_banner = 0 "remove banner
let g:netrw_browse_split = 3 "open file in new tabs
let g:netrw_winsize = 15
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
set guifont=Fira_Code_Nerd_Font:h16
filetype plugin indent on
"----------- GENERAL MAPPINGS ------------
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>d :Lexplore<cr>
nnoremap <leader>nt gt
nnoremap <leader>pt gT
"------------ AUTOCOMMANDS ---------------
augroup netrw_navigation
  autocmd!
  au FileType netrw nmap <buffer> l <cr>
augroup END

"------------ PLUGINS
call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'



call plug#end()
set t_Co=256
set cursorline
colorscheme onehalfdark

lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
END
