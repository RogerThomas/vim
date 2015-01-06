set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'nvie/vim-flake8'
Bundle 'davidhalter/jedi-vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'ervandew/supertab'
Bundle 'tmhedberg/SimpylFold'
" Bundle 'scrooloose/syntastic'

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
set softtabstop=4
set showmatch " Show matching brackets.
set backspace=indent,eol,start
let g:syntastic_python_flake8_args = "--ignore=E501"
" let g:flake8_show_in_gutter=0
" let g:flake8_show_quickfix=0
" let g:flake8_show_in_file=1

" let g:PyLintOnWrite = 1

function TrimEndLines()
    let save_cursor = getpos(".")
    :silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction


autocmd BufWritePost *.py call Flake8()
autocmd FileType python map <buffer> <f3> :call Flake8()<cr>
autocmd BufWritePre *.py :%s/\s\+$//e " remove trailing wwhitespace chars
autocmd BufWritePre *.py call TrimEndLines()
" Move to last poostion
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
autocmd BufRead,BufNewFile *.alph set filetype=alph

set background=dark
