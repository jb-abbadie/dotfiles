set shell=bash
set shellpipe=2>/dev/null>

" ============
" Plugins here
" =============
call plug#begin('~/.local/share/nvim/plugged')

" Theme
Plug 'ishan9299/nvim-solarized-lua'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Language
Plug 'towolf/vim-helm'
Plug 'ray-x/go.nvim'
Plug 'sheerun/vim-polyglot'

" Finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Misc
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdcommenter'
Plug 'luochen1990/rainbow'
Plug 'aserowy/tmux.nvim'

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
Plug 'ray-x/cmp-treesitter'
Plug 'ray-x/lsp_signature.nvim'

" Debug
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" LSP/treesitter
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'svermeulen/vimpeccable'
call plug#end()

" ==============
" General Config
" ==============
luafile ~/.config/nvim/config.lua
