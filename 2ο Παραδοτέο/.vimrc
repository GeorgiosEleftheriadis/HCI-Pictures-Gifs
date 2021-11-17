"@George Eleftheriadis - my basic amateur .vimrc :P

" No compatibility with Vi ( Vims older version )
set nocompatible

" Enable cursor line highlight
set cursorline

" Tab completion in vim's command line
set wildmenu

" No errorbells at end of line
set belloff=all

" Identation for python
set autoindent
set smartindent
set tabstop=8
set softtabstop=4
set shiftwidth=4
set noexpandtab

" Line numbers
set nu

" Case sensitive search
set smartcase

" Top down search
set incsearch

" Highlight search results
set hlsearch

" Plug-ins
call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
Plug 'sjl/badwolf'
" Manual pages for vim
Plug 'vim-utils/vim-man'
" Tree file explorer
Plug 'preservim/nerdtree'
" Autocompletion for python
Plug 'davidhalter/jedi-vim'
" Parentheses/bracket/etc.. matching
Plug 'jiangmiao/auto-pairs'
" Parentheses/brackets/etc.. highlight
Plug 'frazrepo/vim-rainbow'
" Python syntax highlight
Plug 'vim-python/python-syntax'
" Syntax check
Plug 'vim-syntastic/syntastic'
" Status line
Plug 'itchyny/lightline.vim'

call plug#end()

" Colorscheme settings
set bg=dark
colorscheme badwolf

" NerdTree settings
nnoremap <F1> :NERDTreeToggle<CR>

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args='--ignore=E501'
 
" Vim-rainbow settings
let g:rainbow_active = 1

" Lightline settings
set laststatus=2
set noshowmode

" Python code highlight settings
let g:python_highlight_all = 1

" Jedu autocompletion settings
let g:jedi#show_call_signatures = "2"

" Syntax highlight
syntax enable

" Run file-specific scripts automatically
filetype plugin on
