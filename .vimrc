" ---
" Vim-plug  with auto install 
" ---
set nocompatible  " no compatible with vi-mode
filetype off
filetype plugin indent on

" after vim-plug is downloaded, you need to manually call :PlugInstall
if empty(glob('~/.vim/autoload/plug.vim'))
    echo "Installing vim-plug..."
    !curl -fLo ~/.vim/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" ---
" global 
" ---
" + use spacebar as leader as it's reachable by both hands,
" and doesn't compromise ',' and ';' for repeating actions. 
let mapleader = " "

" change current working directory to current file
nnoremap <leader>cd :cd %:p:h<CR>

" + return to last edit position when opening files
" https://vimhelp.org/usr_05.txt.html#last-position-jump
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line('$') |
    \   exe "normal! g`\"" |
    \ endif

" + split window and navigation shortcuts
set splitright

nnoremap <Leader>wv :vsplit<CR>
nnoremap <Leader>wh :split<CR>
nnoremap <Leader>wm <C-W>\| <C-W>_
nnoremap <Leader>w= <C-W>=

nnoremap <Leader>wo <C-W>o

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" + tab shortcuts
set tabpagemax=100

nnoremap te :tabedit <C-R>=expand('%:p:h')<CR>/
nnoremap tn :tabnew<Enter>
nnoremap tc :tabclose<Enter>
nnoremap to :tabonly

" ,t1 ,t2 ,t3: go specific tab
for i in range(1, 9)
    exec 'nnoremap t'.i.' '.i.'gt'
endfor

" + open terminal
nnoremap <leader>` :terminal<Enter>
" shortcut to close terminal which had its own namespace for commands
" it may cause starnge arrow key behavior with single escape, ref.:
" https://vi.stackexchange.com/questions/31645/weird-arrow-key-behaviour-in-fzf-vim-terminal-mode/33177
" :tnoremap <Esc><Esc> <C-\><C-n>:q!<CR>
" don't use this, it breaks fzf.vim's popup. just use <c-d> or exit

" + enable copy to system clipboard
set clipboard=unnamed
" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost + if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" --- 
"  displaying 
" ---
syntax on

set number
set ruler
set textwidth=80
set wrap
set linebreak
set showmatch
set hlsearch " default off in vim, but default on in nvim
set list
set listchars=tab:▹\ ,trail:▵

" set cursor shape for different modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" pum: PopUp Menu which is triggered by Ctrl-N in insert mode
set pumheight=16
set showcmd

" keep space from top and bottom
set scrolloff=2

" folding
set foldmethod=indent " default to python
set foldlevel=0
set foldnestmax=3
set nofoldenable
noremap <Leader>tf :set foldenable!<CR>:set foldenable?<CR>

highlight ColorColumn ctermbg=lightgrey

" use % to travel paired tags
runtime macros/matchit.vim

" --- 
" editing 
" ---
set autoindent
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" refine the arrow keys
noremap <down> g<down>
noremap <up> g<up>
noremap j gj
noremap k gk

" + move lines up and down
" don't map <A> or <M>. it doesn't work.
nnoremap <C-S-Up> :m .-2<CR>==
inoremap <C-S-Up> <ESC>:m .-2<CR>==gi
vnoremap <C-S-Up> :m '<-2<CR>gv=gv

nnoremap <C-S-Down> :m .+1<CR>==
inoremap <C-S-Down> <ESC>:m .+1<CR>==gi
vnoremap <C-S-Down> :m '>+1<CR>gv=gv



" --- 
" behavior 
" ---
set mouse=a

set wildmenu
set lazyredraw
set showmatch

set incsearch
set ignorecase
" be case-sensitive when contains upper char
set smartcase
set hlsearch
set nowrapscan
" make no delay after esc
set ttimeoutlen=0

" don't backup
set nobackup
set nowb
set noswapfile

" configure backspace so it acts as it should do
set backspace=eol,start,indent

" fix delete key in cygwin or other terminals
map <Esc>[3~ <Del>
let &t_kD = "\x1b[3~""]"

" --- 
" plugins 
" ---
call plug#begin('~/.vim/plugged')
Plug 'kamykn/spelunker.vim'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
if has('nvim') || has('patch-8.0.902')
    Plug 'mhinz/vim-signify'
else
    Plug 'mhinz/vim-signify', { 'branch': 'legacy'  }
endif
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'jbgutierrez/vim-better-comments'
Plug 'honza/vim-snippets'
Plug 'terryma/vim-expand-region'
Plug 'vim-scripts/python_match.vim'
Plug 'dense-analysis/ale'
Plug 'luochen1990/rainbow'
Plug 'gregsexton/MatchTag'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'thinca/vim-ambicmd'
Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/tagbar'
Plug 'thaerkh/vim-indentguides'
Plug 'michaeljsmith/vim-indent-object'
Plug 'gcmt/taboo.vim'
Plug 'webdevel/tabulous'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" let vim set project root as cwd automatically
Plug 'airblade/vim-rooter'


" + PHP-specific plugins
Plug 'arnaud-lb/vim-php-namespace', { 'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'tag': '+', 'do': 'composer install --no-dev -o'}
" Plug 'adoy/vim-php-refactoring-toolbox'

" + Python specific plugins
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python'}


" + plugins to try
" Plug 'neoclide/coc.nvim', {'branch': 'release'} ......it requires node.js
" Plug 'garbas/vim-snipmate'
" Plug 'scrooloose/syntastic'
"Plug 'SirVer/ultisnips' ...... it may be very slow for nvim

" + aborted plugins
" Plug 'maralla/completor.vim' " use language-specific completion tools instead
" Plug 'ctrlpvim/ctrlp.vim' ......it's very slow and fzf can do the same
" Plug 'Yggdroot/indentLine' " this is too ugly
" Plug 'ervandew/supertab' " just no need to use it when familiar with c-n c-p

" + Themes
" Plug 'moskytw/luthadel.vim', {'as': 'luthadel'}
" Plug 'joshdick/onedark.vim'
" Plug 'cocopon/iceberg.vim'
" Plug 'arcticicestudio/nord-vim'
" Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'haishanh/night-owl.vim'
call plug#end()

" ---
" Plugin settings
" ---

" + custom themes must be put here after plugins are called
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif
colorscheme night-owl

" + use fzf to act as command pallette and  finder
" prepare for ctrl-p like functionality by fzf to look up for .git
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()

" intellij style, meaning 'action'
nnoremap <leader>a :Commands<Enter> 
" VSCode style, meaning 'ctrl-p'. search current folder by default, :cd to other
nnoremap <leader>p :ProjectFiles<Enter>
" search file with path to be specified, pwd if not assigned
nnoremap <leader>sf :Files
" search tags, global
nnoremap <leader>st :Tags<Enter>
" search tags, current buffer
nnoremap <leader>so :BTags<Enter>
" TODO: remove 'search tag' as we are moving to lsp-based workflow
" search history file
nnoremap <leader>sh :History<Enter>
" search buffer
nnoremap <leader>sb :Buffers<Enter>
" global search with Ag
nnoremap <leader>ss :Ag<Enter>

" + search with Google
" may not be applicable with WSL as it cannot find browser
nmap <Leader>sg <Plug>SearchNormal
vmap <Leader>sg <Plug>SearchVisual

" + use NERDTree as file tree manager
" 'file tree toggle'
nnoremap <leader>ft :NERDTreeToggle<Enter>
" toggle by looking up VCS root
nnoremap <leader>fv :NERDTreeToggleVCS<Enter>
" 'file tree focus'
nnoremap <leader>ff :NERDTreeFocus<Enter>
" 'file tree reveal'
nnoremap <leader>fr :NERDTreeFind<Enter>
" close vim when there's only NERDTree left
autocmd bufenter + if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" + tag settings
" use tagbar for code Outline
nnoremap <leader>o :TagbarToggle<Enter>
" put tags into dedicated folder
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" create the tags folder if it doesn't exist
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" + gutentags config
let g:gutentags_project_root = ['.root',  '.git', '.project', '.vscode', '.idea','package.json', 'composer.json']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
set statusline+=%{gutentags#statusline()}

" + setup which key hint popup
nnoremap <silent> <leader> :WhichKey ' '<CR>
vnoremap <silent> <leader> :WhichKeyVisual ' '<CR>

" don't map 'c', 'g', 'z'... etc. as they need too much hacking around for built-in commands
" you still need a binding to quickly ask for key mapping
function AskKeyInputForWhichKey()
    let input = input("Which single key are you looking for its map? ")
    execute "WhichKey ". '"'. input . '"'
endfunction
nnoremap <leader>? :call AskKeyInputForWhichKey()<CR>
nnoremap <silent> m :WhichKey 'm'<CR>
nnoremap <silent> t :WhichKey 't'<CR>

" + let spelunker handle spell check
set nospell
let g:enable_spelunker_vim = 0 " turn off on start


" + vim-highlightedyank settings
let g:highlightedyank_highlight_duration = 1000
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

" + visual guides
let g:rainbow_active = 1 

" + use ctrl+/ for commenting, but <c-/> can't be directly mapped, use c-_ as workaround.
nmap <C-_> <Plug>CommentaryLine
vmap <C-_> <Plug>Commentary
imap <C-_> <Esc><Plug>CommentaryLine

" + PHP specific settings
" gh and gd
autocmd Filetype php nnoremap gh :PhpactorHover<Enter>
autocmd Filetype php nnoremap gd :PhpactorGotoDefinition<Enter>

" PHP namespace: 'leader u' to insert 'Use' and 'leader e' to expand full name
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction

autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>

" + python-mode settings
let g:pymode_options_max_line_length = 88 " use black's rule
let g:pymode_options_colorcolumn=1
