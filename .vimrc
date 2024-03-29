" to prevent from overlapping of previous vimrc version
:mapclear

set nocompatible  " no compatible with vi-mode
filetype off
filetype plugin indent on

" Vim-plug  with auto install 
" after vim-plug is downloaded, you need to manually call :PlugInstall
if empty(glob('~/.vim/autoload/plug.vim'))
    echo "Installing vim-plug..."
    !curl -fLo ~/.vim/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" ---
" global behavior
" ---
" apply vimrc settings immediately. same as that in .ideavimrc
nnoremap zso :source ~/.vimrc<CR>

" use spacebar as leader as it's reachable by both hands,
" and doesn't compromise ',' and ';' for repeating actions. 
let mapleader = ' '

" return to last edit position when opening files
" https://vimhelp.org/usr_05.txt.html#last-position-jump
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line('$') |
    \   exe "normal! g`\"" |
    \ endif


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

set rnu
set ruler
set textwidth=80
set wrap
set linebreak
set showmatch
set hlsearch " default off in vim, but default on in nvim
set list

" set cursor shape for different modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" + popup menu
" pum: PopUp Menu which is triggered by Ctrl-N in insert mode
set pumheight=16
set showcmd
" The default is ".,w,b,u,t,i", which means to scan:
" current buffer, buffers in other windows, other loaded buffers, 
" unloaded buffers, tags, included files.
" let's diable 't' here as 'scanning tags' destroys performance 
" and we are not actually using ctags when lsp's here
set complete-=t
set completeopt=menu,menuone,preview,noselect
set shortmess+=c " suppress annoy messages.


" keep space from top and bottom
set scrolloff=2

" folding
set foldmethod=indent " default to python
set foldlevel=0
set foldnestmax=3
set nofoldenable

highlight ColorColumn ctermbg=lightgrey

" use % to travel paired tags
runtime macros/matchit.vim

" --- 
" built-in shortcut keys
" ---
inoremap jj <Esc>
nnoremap U :redo<CR>

nnoremap zh ^
inoremap zh <Esc>i
nnoremap zl $
inoremap zl <End>

" thought there's peekaboo, we stil need this one to be consitend with intellij
nmap <leader>" :registers<CR>

" + toggles
" Relative or absolute number lines
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction
nnoremap Tl :call NumberToggle()<CR>
nnoremap Tf :set foldenable!<CR>:set foldenable?<CR>
nnoremap Th :noh<CR>

" change current working directory to current file
nnoremap Td :cd %:p:h<CR>

" + move lines up and down
" don't map <A> or <M>. it doesn't work.
nnoremap <C-S-j> :m .+1<CR>==
nnoremap <C-S-k> :m .-2<CR>==
inoremap <C-S-j> <Esc>:m .+1<CR>==gi
inoremap <C-S-k> <Esc>:m .-2<CR>==gi
vnoremap <C-S-j> :m '>+1<CR>gv=gv
vnoremap <C-S-k> :m '<-2<CR>gv=gv

" + tab shortcuts
set tabpagemax=100

nnoremap te :tabedit <C-R>=expand('%:p:h')<CR>/
nnoremap to :TabooOpen 
nnoremap tr :TabooRename 
nnoremap tc :tabclose<Enter>
" meaning 'Close all others'
nnoremap tC :tabonly

" ,t1 ,t2 ,t3: go specific tab
for i in range(1, 9)
    exec 'nnoremap t'.i.' '.i.'gt'
endfor

" + open terminal
nnoremap <leader>` :below terminal<Enter>
" shortcut to close terminal: <c-d>, which had its own namespace for commands
" don't use this :tnoremap <Esc><Esc> <C-\><C-n>:q!<CR>
" it breaks fzf.vim's popup. just use <c-d> or exit
" ref.: https://vi.stackexchange.com/questions/31645/weird-arrow-key-behaviour-in-fzf-vim-terminal-mode/33177
 
" --- 
" behavior 
" ---
set autoindent
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set mouse=a
set belloff=all
set splitright

set wildmenu
set lazyredraw
set showmatch

set incsearch
set ignorecase
" be case-sensitive when contains upper char
set smartcase
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

" Plug 'dense-analysis/ale'
" + lsp plugins 
Plug 'skywind3000/vim-auto-popmenu'
" shows match counts when searching
Plug 'google/vim-searchindex'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
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
Plug 'vim-scripts/python_match.vim'
Plug 'luochen1990/rainbow'
Plug 'gregsexton/MatchTag'
Plug 'machakann/vim-highlightedyank'
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
" automatically toggle absolute number for unfocused buffer 
" when relativenumber enabled.
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" let vim able to open file by line, e.g. vim ~/.vimrc:20
Plug 'bogado/file-line'
Plug 'liuchengxu/vista.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'tommcdo/vim-exchange'
" helps to show marks
Plug 'kshenoy/vim-signature'
Plug 'voldikss/vim-browser-search'


" + Python specific plugins
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python'}


" + js/ts specific plugins
Plug 'pangloss/vim-javascript', { 'for': 'javascript'}
Plug 'leafgarland/typescript-vim'

let g:javascript_plugin_jsdoc = 1


" + plugins to try
" Plug 'garbas/vim-snipmate'
" trailing-white-space
" vim-test
" auto venv
"
" don't use ale as lsp-settings is too convenient.
" however stand-alone refactoring tools need to be installed, 
" and language-specific refactors are better.

" + aborted plugins
"Plug 'SirVer/ultisnips' ...... it may be very slow for nvim
" Plug 'scrooloose/syntastic'
" Plug 'neoclide/coc.nvim', {'branch': 'release'} ......it requires node.js
" Plug 'maralla/completor.vim' " use language-specific completion tools instead
" Plug 'ctrlpvim/ctrlp.vim' ......it's very slow and fzf can do the same
" Plug 'Yggdroot/indentLine' " this is too ugly
" Plug 'ervandew/supertab' " just no need to use it when familiar with c-n c-p
" spelunker's default key binding uses 'z', conflict with many current ones
" TODO: configure built-in spell checks
" Plug 'kamykn/spelunker.vim'

" + Themes
Plug 'haishanh/night-owl.vim'
call plug#end()

" ---
" Plugin settings
" ---
" + use space as easymotion input trigger. 
" that's why it's not assigned to leader key
nmap \ <Plug>(easymotion-s)

" + ALE settings.it's the core for linting and LSP features.
" only do linting when file is saved, as vim is often used as code reader.
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_on_enter = 0 
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)


" gh and gd
nnoremap gh :LspHover<Enter>
nnoremap gd :LspDefinition<Enter>

" goto
nnoremap gr :LspReferences<Enter>
 
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
" TODO: these two should be refactored to using LSP, 
" but still need to consider when LSP not enabled.
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
nnoremap <Leader>sg <Plug>SearchNormal
vnoremap <Leader>sg <Plug>SearchVisual

" + use NERDTree as explorer
" 'explorer toggle'
nnoremap <leader>et :NERDTreeToggle<Enter>
" toggle by looking up VCS root
nnoremap <leader>ev :NERDTreeToggleVCS<Enter>
" 'explorer focus'
nnoremap <leader>ef :NERDTreeFocus<Enter>
" 'explorer reveal'
nnoremap <leader>er :NERDTreeFind<Enter>
" close vim when there's only NERDTree left
autocmd bufenter + if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" + tag and symbol settings
" use tagbar for code Outline
" nnoremap <leader>o :TagbarToggle<Enter>
" put tags into dedicated folder
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" create the tags folder if it doesn't exist
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" vista settings
let g:vista_executive_for = {
    \ 'python': 'vim_lsp',
    \ 'typescript': 'vim_lsp',
    \ 'javascript': 'vim_lsp',
\ }
let g:vista_ignore_kinds = ['Variable']
nnoremap <leader>o :Vista!!<cr>

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
nnoremap <silent> t :WhichKey 't'<CR>

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

" enable  plugin vim-auto-popmenu for filetypes, '*' for all files.
let g:apc_enable_ft = { '*':1 }

" + placehoder for refactoring, maybe should put into language specific sections
" <leader>r
 
" + python-mode settings
let g:pymode_options_max_line_length = 88 " use black's rule
let g:pymode_options_colorcolumn=1


" + placehoder for testing
" <leader>t
 
" + Git commands, mostly with fugitive
nnoremap <leader>ga. :Git add .<CR>
nnoremap <leader>gcam :Git commit -am ""
nnoremap <leader>gck :Git checkout
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>
" git status
nnoremap <leader>gst :below Git<CR>
nnoremap <leader>glog :below Git log<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gh :GBrowse<CR>
nnoremap <leader>gdf :below Git diff<CR>
nnoremap <leader>gsl !git stash list<CR>
nnoremap <leader>gss !git stash save<CR>
nnoremap <leader>gsa !git stash apply<CR>

