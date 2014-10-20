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
Bundle 'scrooloose/syntastic'
Bundle 'davidhalter/jedi-vim'

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
let g:flake8_max_line_length=99
autocmd BufWritePost *.py call Flake8()
