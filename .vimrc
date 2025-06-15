"-------------------
" Plugin Management
"-------------------

call plug#begin()
Plug 'RyanMillerC/better-vim-tmux-resizer'
Plug 'christoomey/vim-tmux-navigator'
Plug 'maxmx03/solarized.nvim'
Plug 'tpope/vim-surround'
call plug#end()

"-----------------
" Editor Settings
"-----------------

" Theme
set termguicolors
set background=dark
lua << EOF
require('solarized').setup({
  transparent = {
    enabled = true,
  }
})
EOF
colorscheme solarized

" Editor settings
set hlsearch
set number
set mouse=a
set relativenumber
set shiftwidth=2
set smarttab
set softtabstop=0
set tabstop=8

" Enable spell check
setlocal spell spelllang=en_us

" ChatGPT...
set timeout
set ttimeout
set timeoutlen=500
set ttimeoutlen=10

"-----------------
" Plugin Settings
"-----------------
" I use custom mappings for navigator/resizer
let g:tmux_navigator_no_mappings=1
let g:tmux_resizer_no_mappings=1

"-------------
" Keybindings
"-------------

" Swap splits with Tab
nnoremap <Tab> <C-w><C-w>

" Tmux Navigation
nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>

" Tmux Resizing
nnoremap <silent> <M-Left> :TmuxResizeLeft<CR>
nnoremap <silent> <M-Right> :TmuxResizeRight<CR>
nnoremap <silent> <M-Up> :TmuxResizeUp<CR>
nnoremap <silent> <M-Down> :TmuxResizeDown<CR>
