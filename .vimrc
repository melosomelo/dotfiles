"basic vim configurations 
set number "show number of lines
set hlsearch "highlight search results
set shiftwidth=2 "identation width of > and < operators
set shiftround "When shifting lines, round the indentation to the nearest multiple of “shiftwidth.”
set numberwidth=4 "number of columns used for the line number. a.k.a. left-padding in the terminal
set nowrap "does not wrap long lines into multiple lines
set autoindent "New lines inherit the indentation of previous lines.
set expandtab "Convert tabs to spaces
set tabstop=2 "indent using 2 spaces
set mouse=a "enable mouse use in all modes

syntax on 
filetype plugin indent on


" sourcing the plugins file 
if filereadable(expand("~/.vimrc.plug"))
  source ~/.vimrc.plug
 endif
