local opt = vim.opt
local g = vim.g

-- General settings
opt.ruler = false 
opt.exrc = true
opt.relativenumber = true
opt.autoindent = true
opt.smarttab = true
opt.number = true
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = '~/.config/nvim/undodir'
opt.incsearch = true
opt.scrolloff = 10
opt.signcolumn = 'yes'
opt.title = true
opt.autoread = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.expandtab = true
opt.fileencoding = 'utf-8'

g.mapleader = " "
opt.mouse = "a"
-- filetype plugin indent on

-- " Plugins
-- call plug#begin()
-- Plug 'preservim/nerdtree'
-- Plug 'junegunn/fzf.vim'
-- Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
-- Plug 'airblade/vim-rooter'
-- Plug 'sainnhe/sonokai'
-- Plug 'neoclide/coc.nvim', {'branch': 'release'}
-- Plug 'vim-airline/vim-airline'
-- Plug 'vim-airline/vim-airline-themes'
-- Plug 'tpope/vim-commentary'
-- Plug 'farmergreg/vim-lastplace'
-- call plug#end()

-- " NERDTree config
-- nnoremap <C-n> :NERDTree<CR>

-- " FZF Config
-- nnoremap <silent> <C-f><C-w> :Ag<CR>
-- nnoremap <silent> <C-f><C-f> :GFiles<CR>

-- " COC Config
-- inoremap <silent><expr> <TAB>
--       \ pumvisible() ? "\<C-n>" :
--       \ CheckBackspace() ? "\<TAB>" :
--       \ coc#refresh()
-- inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

-- function! CheckBackspace() abort
--   let col = col('.') - 1
--   return !col || getline('.')[col - 1]  =~# '\s'
-- endfunction

-- " Airline settings
-- let g:airline_powerline_fonts = 1
-- let g:airline_section_z = ""
-- let g:airline_skip_empty_sections = 1

-- " VIM Last Place

-- Theme settings 
opt.termguicolors = true
g.sonokai_style = 'andromeda'
g.sonokai_better_performance = 1
vim.cmd("silent! colorscheme sonokai")
vim.cmd("silent! syntax enable")
vim.cmd("silent! hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("silent! hi EndOfBuffer guibg=NONE ctermbg=NONE")
