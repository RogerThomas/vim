call plug#begin('~/.local/share/nvim/plugged')

Plug 'nvie/vim-flake8'
Plug 'ervandew/supertab'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'carlitux/deoplete-ternjs'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }

Plug 'davidhalter/jedi-vim'  " Auto
Plug 'deoplete-plugins/deoplete-jedi'

" Shows changes/additions on the left hand side
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'

call plug#end()

let g:SuperTabDefaultCompletionType = "<c-n>"  " By default tab is go up not down

call deoplete#custom#option('num_processes', 4)
let g:deoplete#enable_at_startup = 1
let g:jedi#completions_enabled = 0
let g:python3_host_prog = '/Users/roger.thomas/virtualenvs/neovim3/bin/python'
let g:deoplete#sources#jedi#show_docstring = 1


let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
let g:ale_linters = {'javascript': ['pretier', 'eslint'], 'vue': ['eslint', 'vls']}
let b:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters_explicit = 1

let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"


" Basic -------------------------------------------------------
set list  " Shows whitespace chars as chars
set number  " Shows line numbers on the LHS

" B Makes tab do spaces
set expandtab
set tabstop=4
set sw=4
set softtabstop=4
" E Makes tab do spaces

set showmatch  " Show matching brackets

set backspace=indent,eol,start
set mouse=a
set encoding=utf8
" -------------------------------------------------------------


function TrimEndLines()
    let save_cursor = getpos(".")
    :silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction


autocmd BufWritePost *.py call Flake8()

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype vue setlocal ts=2 sts=2 sw=2
autocmd BufWritePre *.py,*.rb,*.js,*.json,*.sql,*.rst,*.vue,*.md,Dockerfile,*.txt :%s/\s\+$//e " Remove trailing wwhitespace chars
autocmd BufWritePre *.py,*.rb,*.js,*.json,*.sql,*.rst,*.vue,*.md,Dockerfile,*.txt call TrimEndLines() " Remove trailing newline chars


" Move to last position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd BufNewFile,BufRead Jenkinsfile setf groovy
