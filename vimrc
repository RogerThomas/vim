set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
" Not sure about powerline
" Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'nvie/vim-flake8'
Bundle 'davidhalter/jedi-vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'ervandew/supertab'
Bundle 'tmhedberg/SimpylFold'
Bundle 'elzr/vim-json'
" Bundle 'Valloric/YouCompleteMe'
" Bundle 'scrooloose/syntastic'
Plugin 'jelera/vim-javascript-syntax'
" Bundle 'wookiehangover/jshint.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'jmcantrell/vim-virtualenv'
Plugin 'fisadev/vim-isort'


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
set mouse=a
syntax on
set ruler
let g:syntastic_python_flake8_args = "--ignore=E501"
let g:virtualenv_auto_activate = 1
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
autocmd BufWritePre *.py Isort!
autocmd FileType python map <buffer> <f3> :call Flake8()<cr>
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd BufWritePre *.py,*.rb,*.js,*.json,*.sql :%s/\s\+$//e " remove trailing wwhitespace chars
autocmd BufWritePre *.py,*.rb,*.js,*.json,*.sql call TrimEndLines()
" Move to last position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
autocmd BufRead,BufNewFile *.alph set filetype=alph

set background=dark

if has('python')
py << EOF
import os
import os.path, sys
import vim

if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
    python_version = os.listdir(project_base_dir + '/lib')[0]

    site_packages = os.path.join(project_base_dir, 'lib', python_version, 'site-packages')
    current_directory = os.getcwd()

    sys.path.insert(1, site_packages)
    sys.path.insert(1, current_directory)
EOF
endif
