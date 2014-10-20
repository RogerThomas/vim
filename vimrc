set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'nvie/vim-flake8'
" Bundle 'scrooloose/syntastic'
Bundle 'davidhalter/jedi-vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/pylint-mode'

" The bundles you install will be listed here

filetype plugin indent on

" The rest of your config follows here
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 90
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%90v.*/
    autocmd FileType python set nowrap
    augroup END

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2
set list
set number
set expandtab
set tabstop=4
set sw=4
set showmatch " Show matching brackets.
set backspace=indent,eol,start
let g:flake8_max_line_length=99
autocmd BufWritePost *.py call Flake8()

" Move to last poostion
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

autocmd BufWritePre *.py :%s/\s\+$//e " remove trailing wwhitespace chars
set background=dark

function TrimEndLines()
    let save_cursor = getpos(".")
    :silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction

au BufWritePre *.py call TrimEndLines()
