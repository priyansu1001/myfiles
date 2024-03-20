" set things
"
set number
set relativenumber
set autoindent
set tabstop=4
set mouse=a
set shiftwidth=4
set smarttab
set softtabstop=4

" Plugins

call plug#begin()


Plug 'https://github.com/vim-airline/vim-airline' " Status bar / vim-airline
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " treesitter
" Plug 'andweeb/presence.nvim'  
Plug 'IogaMaster/neocord' " discord rich presence
Plug 'nvim-lua/plenary.nvim' " fuzzy finder need
Plug 'nvim-telescope/telescope.nvim', { 'Branch': '0.1.x' } " fuzzy finder


call plug#end()

" Plugins config

" discord rich presence config
call v:lua.require'neocord'.setup_no_return(#{
    \ logo: 'auto',
    \ })


"my remaps 


nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

