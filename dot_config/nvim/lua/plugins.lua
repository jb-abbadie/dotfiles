-- =======
-- Plugins
-- =======
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Theme
    'ishan9299/nvim-solarized-lua',
    'hoob3rt/lualine.nvim',
    'nvim-tree/nvim-web-devicons',

    -- Language
    {
        "ray-x/go.nvim",
        dependencies = {  -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },

    -- Finder
    {'nvim-telescope/telescope.nvim',
        keys = {
            { "<C-p>", ":Telescope find_files<cr>", desc = "Open telescope file picker" },
            {"<C-g>",  ":Telescope live_grep<CR>", desc = "Open telescope livegrep"},
        },
        dependencies = { 
            'nvim-lua/plenary.nvim' ,
            'nvim-telescope/telescope-ui-select.nvim',
        }
    },

    -- Misc
    'lewis6991/gitsigns.nvim',
    {'numToStr/Comment.nvim', lazy = false},
    'svermeulen/vimpeccable',

    {
    'mrjones2014/smart-splits.nvim',
    config = function()
        require('smart-splits').setup()
        vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
        vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
        vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
        vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)

        vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
        vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
        vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
        vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
    end,
    lazy = false,
    },

    -- Completion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/vim-vsnip',
    'ray-x/cmp-treesitter',
    'ray-x/lsp_signature.nvim',

    -- Debug
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',

    -- LSP/treesitter
    'neovim/nvim-lspconfig',
    'onsails/lspkind-nvim',
    { 'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function ()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = "all",
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true
                },
            })
        end
    },

    -- LLM
    {
        "David-Kunz/gen.nvim",
        opts = {
            model = "deepseek-coder:6.7b", -- The default model to use.
            host = "localhost", -- The host running the Ollama service.
            port = "11434", -- The port on which the Ollama service is listening.
            display_mode = "float", -- The display mode. Can be "float" or "split".
            show_prompt = false, -- Shows the Prompt submitted to Ollama.
            show_model = false, -- Displays which model you are using at the beginning of your chat session.
            no_auto_close = false, -- Never closes the window automatically.
            init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
            -- Function to initialize Ollama
            command = function(options)
                return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
            end,
            -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
            -- This can also be a command string.
            -- The executed command must return a JSON object with { response, context }
            -- (context property is optional).
            -- list_models = '<omitted lua function>', -- Retrieves a list of model names
            debug = false -- Prints errors and the command which is run.
        }
    },
})



