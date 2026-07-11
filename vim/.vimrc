"-------------------------------------------------------------------------------
" general settings
"

" set leader key
let mapleader = "\<Space>"

" use vim mode (not Vi-compatible)
set nocompatible

" filetype plugins
filetype plugin on
filetype indent on

" use mouse
if match($TERM, "screen") != -1
  set ttymouse=xterm2
endif
set mouse=a

" set line numbers
set number                     " Show current line number
set relativenumber             " Show relative line numbers


" switch between buffers
nnoremap <leader>bn :bnext<CR>      " go to next buffer
nnoremap <leader>bp :bprevious<CR>  " go to previous buffer

" autosave when exiting insert mode
autocmd InsertLeave * silent! write | echo "File saved!"


"-------------------------------------------------------------------------------
" appearance
"
" do not equalize the size of the buffers
set noequalalways

" wildcard matching
set wildmenu
set wildmode=longest:full
set wildignore=*.o,*.os,*.so,*~

" show current position
set ruler

" backspace behavior
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" search behavior
set noignorecase
set smartcase
set hlsearch
set incsearch

" no redraw during execution of macros
set lazyredraw

" regular expressions
set magic

" visual: show matching brackets
set showmatch
set mat=5

" no sound on errors
set noerrorbells
set novisualbell

" syntax highlighting
syntax enable
hi Comment ctermfg=LightCyan cterm=NONE

" utf8 encoding
set encoding=utf8

" filetype order preference
set ffs=unix,dos,mac


"-------------------------------------------------------------------------------
" files, backups, and undo
"

" do not crate backup files
set nobackup

" set to read-only if the file is modified from the outside
set autoread

" save when text changes or when leaving insert mode
augroup autosave
  autocmd!
  autocmd TextChanged,InsertLeave <buffer> if &readonly == 0 | silent write | endif
augroup END

"-------------------------------------------------------------------------------
" text editing
"
" tab indent: 2 and no tabs (replace by spaces)
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2

" mark tabs and trailing spaces
set list
set listchars=tab:>-,trail:-

" C-style indent
set cindent

" keep 3 lines below/above cursor when scrolling
set scrolloff=3

" support modelines
set modeline
set modelines=5

" display man pages in a Vim buffer
" key bindings: see https://vimdoc.sourceforge.net/htmldoc/usr_12.html#find-manpage
runtime! ftplugin/man.vim

"-------------------------------------------------------------------------------

" Install Plugings via vim-plug

call plug#begin('~/.vim/plugged')

" YouCompleteMe for code completion (C-family only)
"Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer' }

" vim-fugitive for Git integration
Plug 'tpope/vim-fugitive'

" tagbar for code structure browser
Plug 'preservim/tagbar'

" fuzzer ctrlp
Plug 'ctrlpvim/ctrlp.vim'

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" termdebug
Plug 'epheien/termdbg'

" vimtex
Plug 'lervag/vimtex', { 'tag': 'v2.15' }

call plug#end()


"-------------------------------------------------------------------------------
" Fugitive plugin: show Git status in statusline
"
hi CVSStatus cterm=bold ctermbg=LightGray ctermfg=DarkBlue
hi StatusLine cterm=NONE ctermbg=LightGray ctermfg=Black
set laststatus=2
set statusline=
set statusline+=%#CVSStatus#%{FugitiveStatusline()}
set statusline+=%#StatusLine#\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P



"-------------------------------------------------------------------------------  
" tagbar plugin configuration
"
let g:tagbar_width=24
autocmd VimEnter * nested :TagbarOpen


"-------------------------------------------------------------------------------
" youcompleteme plugin configuration
"
"set rtp+=~/.vim/bundle/YouCompleteMe
"autocmd BufRead,BufNewFile * setlocal signcolumn=yes
"
"nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
"nnoremap <leader>gD :YcmCompleter GoToDeclaration<CR>
"nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
"nnoremap <leader>gh :YcmCompleter GetDoc<CR>

"-------------------------------------------------------------------------------
" coc.nvim plugin configuration
"

" Install coc extensions - add more if needed
let g:coc_global_extensions = [
  \ 'coc-pyright',
  \ 'coc-clangd'
  \ ]

" Use Tab and Shift-Tab to navigate completion list
inoremap <silent><expr> <TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use Enter to accept the selected completion item
inoremap <silent><expr> <CR> pumvisible() ? coc#pum#confirm() : "\<CR>"

" Press K to show Documentation
"nmap <silent> K :call CocActionAsync('doHover')<CR>

runtime! ftplugin/man.vim

" Refactoring Shortcut
nmap <leader>rn <Plug>(coc-rename)


"-------------------------------------------------------------------------------
" TermDebug plugin configuration
"
"

" load plugin from pack/*/start/
packadd! termdebug

"-------------------------------------------------------------------------------
" Vimtex plugin configuration
"
"

" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note: Most plugin managers will do this automatically!
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
" Note: Most plugin managers will do this automatically!
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'skim'

" Or with a generic interface:
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
" let g:vimtex_compiler_method = 'latexrun'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
" let maplocalleader = ","
