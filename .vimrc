syntax on
let mapleader = " "

"------------------- BASIC CONFIGURATIONS -------------------
set number
set numberwidth=4
set shiftwidth=2
set tabstop=2
set wrap
set shiftround

"------------------- GENERAL MAPPINGS ----------------------------
nnoremap <s-j> ddp
nnoremap <s-k> ddkP
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>q viw<esc>a"<esc>hbi"<esc>lel
"remapping going to the beginning of the line to H
nnoremap H 0
nnoremap 0 <nop>
"remapping going to the end of the line to L
nnoremap L $
nnoremap $ <nop>
"------------------- ABBREVIATIONS -------------------------------
iabbrev @@ mateusmelornrn@gmail.com

"------------------ AUTOCOMMANDS ---------------------------------
"comment single line
augroup javascript
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <leader>c I//<esc>
  autocmd FIleType javascript iabbrev <buffer> iff if()<left>
augroup END
augroup others
	autocmd!
	autocmd BufNewFile,BufRead *.html setlocal nowrap
augroup END
