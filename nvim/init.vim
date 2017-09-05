"s vimrc automatically installs everything it needs.
" To install, or reinstall, remove ~/.vim directory and open Vim.

set nocompatible
" set re=1
syntax on
filetype off

let needsToInstallPlugins=0
if !isdirectory(expand("~/.vim/bundle/vundle"))
  echo "\nInstalling Vim dependencies... Please be patient!\n" silent !mkdir -p ~/.vim/tmp
  silent !mkdir -p ~/.vim/swap
  silent !mkdir -p ~/.vim/undo
  silent !mkdir -p ~/.vim/bundle
  silent !mkfifo ~/.vim/commands-fifo
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let needsToInstallPlugins=1
endif


set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Do these first, because other plugins depend on them
Plugin 'gmarik/vundle'

Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'gkz/vim-ls'
Plugin 'kassio/neoterm'
Plugin 'mileszs/ack.vim'
Plugin 'slim-template/vim-slim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/tir_black'
Plugin 'frankier/neovim-colors-solarized-truecolor-only'
Plugin 'morhetz/gruvbox'
Plugin 'jacoborus/tender.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'jiangmiao/auto-pairs'
Plugin 'LeonB/HTML-AutoCloseTag'

if needsToInstallPlugins == 1
  echo "\nInstalling Plugins, please ignore key map error messages\n"
  :PluginInstall!
  echo "\nInstalled.\n"
endif

call vundle#end()

filetype plugin indent on

" ==========================
" SETTINGS
" ==========================
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme gruvbox
set background=dark
"hi Normal guibg=NONE ctermbg=NONE

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:enable_bold_font = 1
let g:rehash256 = 1

" Python binary locations
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/home/thomas/.pyenv/shims/python'

set vb t_vb=               " Turn off beep
set lazyredraw             " Don't redraw during macro execution
set synmaxcol=2048         " Stop syntax highlighting for long lines
set number
set nowrap                 " No wrapping by default
set scrolloff=4            " Keep a few lines above and below current line
set equalalways            " create equally sized splits
set splitbelow splitright  " split placement
set wildmode=longest,list  " Makes completion in command mode like bash
set history=1000           " Keep a lot of stuff in history
set nobackup               " Make backups
set backupdir=~/.vim/tmp/  " Keep backups in a central location
set directory=~/.vim/swap/ " Keep swap files in a central location
set undofile               " Keep undo history even after closing Vim
set undodir=~/.vim/undo    " Where to store undo history
set timeoutlen=500         " Don't wait so long for ambiguous leader keys
" set noesckeys              " Get rid of the delay when hitting esc!
set gdefault               " assume the /g flag on :s substitutions to replace all matches in a line
set colorcolumn=80
set linespace=5
set hidden
set encoding=utf-8

" Indenting always 4 spaces, Python
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

let python_highlight_all=1
syntax on

" Indent web dev files
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" Highlight trailing whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Search
set smartcase
set hlsearch
set wildignore+=**/tmp
" Cancel search with Esc
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" neovim terminal configuration
tnoremap <Esc> <C-\><C-n>

" neoterm configuration
let g:neoterm_position = 'vertical'

command! Ttrb :T env PARTIAL=false TRUNCATE=true COUNTRIES=nl bundle exec rails runner t.rb; and time env PARTIAL=true TRUNCATE=false COUNTRIES=de bundle exec rails runner t.rb
nnoremap <silent> ,th :Ttrb<cr>

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_


" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

let ruby_no_expensive = 1 " Differentiate between do..end and class..end is slow
let ruby_operators = 1    " Highlight Ruby operators

" netrw file browser settings
" let g:netrw_list_hide  = "\.git,\.DS_Store"
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 20
" let g:netrw_localrmdir='rm -r'
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

" NerdTree
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']
let NERDTreeMapActivateNode='<right>'
let NERDTreeShowHidden=1
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>j :NERDTreeFind<CR>

" Git Gutter
set signcolumn=yes

" Start Supertab from top
let g:SuperTabDefaultCompletionType = "<c-n>"

" Airline Theme
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1

set formatprg=par\ -w80\ -q


" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
let g:SimpylFold_docstring_preview=1

" ==========================
" AUTOCOMMANDS
" ==========================

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Format xml files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" Autocompletion
call deoplete#enable()

autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
autocmd CompleteDone * pclose " To close preview window of deoplete automagically

" ==========================
" FUNCTIONS
" ==========================

" Smart tab autocomplete behavior
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif

