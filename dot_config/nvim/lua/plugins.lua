-- =======
-- Plugins
-- =======
vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'ishan9299/nvim-solarized-lua'
    use 'hoob3rt/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'

    -- Language
    use 'towolf/vim-helm'
    use 'ray-x/go.nvim'
    use 'sheerun/vim-polyglot'
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

    -- Finder
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- Misc
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'preservim/nerdcommenter'
    use 'luochen1990/rainbow'
    use 'aserowy/tmux.nvim'
    use 'svermeulen/vimpeccable'

    -- Completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'
    use 'ray-x/cmp-treesitter'
    use 'ray-x/lsp_signature.nvim'

    -- Debug
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'

    -- LSP/treesitter
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }


end)


