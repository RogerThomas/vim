set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
" call vundle#rc()

" let Vundle manage Vundle
" required! 
" Bundle 'gmarik/vundle'
" Bundle 'tpope/vim-fugitive'
" Not sure about powerline
" Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Bundle 'nvie/vim-flake8'
" Bundle 'davidhalter/jedi-vim'
" Bundle 'airblade/vim-gitgutter'
" Bundle 'ervandew/supertab'
" Bundle 'tmhedberg/SimpylFold'
" Bundle 'elzr/vim-json'
" Bundle 'Valloric/YouCompleteMe'
" Bundle 'scrooloose/syntastic'
" Plugin 'jelera/vim-javascript-syntax'
" Bundle 'wookiehangover/jshint.vim'
" Bundle 'pangloss/vim-javascript'
" Bundle 'jmcantrell/vim-virtualenv'
" Bundle 'fisadev/vim-isort'

" Install plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" call plug#begin('~/.vim/plugged')

"Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
"
"
" Git commands, never used
" Plug 'tpope/vim-fugitive'

" You know what this does
Plug 'nvie/vim-flake8'

" Shows changes/additions on the left hand side
Plug 'airblade/vim-gitgutter'

" Folds don't really use, maybe don't need, maybe slow
" Plug 'tmhedberg/SimpylFold'
"
Plug 'elzr/vim-json'
Plug 'fisadev/vim-isort'
Plug 'ervandew/supertab'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'davidhalter/jedi-vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'psf/black', { 'tag': '19.10b0' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'

" Plug 'dense-analysis/ale'


call plug#end()

filetype plugin indent on

" The rest of your config follows here
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%100v.*/
    autocmd FileType python set nowrap
    augroup END

" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
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
" syntax on
set ruler
set encoding=utf-8


" let g:flake8_show_in_gutter = 0
" let g:pymode_rope = 0
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
let g:ale_linters = {'javascript': ['pretier', 'eslint'], 'vue': ['eslint', 'vls']}
let b:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters_explicit = 1
let g:ale_enabled = 1

let g:deoplete#enable_at_startup = 1
let g:virtualenv_auto_activate = 1
let g:jedi#completions_enabled = 0
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"
let g:SuperTabDefaultCompletionType = "<c-n>"  " By default tab is go up not down
let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.8/bin/python3'

function TrimEndLines()
    let save_cursor = getpos(".")
    :silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

autocmd BufWritePost *.py call Flake8()
autocmd FileType python map <buffer> <f3> :call Flake8()<cr>
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype vue setlocal ts=2 sts=2 sw=2
autocmd BufWritePre *.py,*.rb,*.js,*.json,*.sql,*.rst,*.vue,*.md,Dockerfile,*.txt :%s/\s\+$//e " Remove trailing wwhitespace chars
autocmd BufWritePre *.py,*.rb,*.js,*.json,*.sql,*.rst,*.vue,*.md,Dockerfile,*.txt call TrimEndLines() " Remove trailing newline chars
" Move to last position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
autocmd BufNewFile,BufRead Jenkinsfile setf groovy

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
