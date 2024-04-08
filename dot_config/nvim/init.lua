require('plugins')

-- ==============
-- General Config
-- ==============
vim.g.mapleader = ","

vim.opt.timeout = false
vim.opt.number = true
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.clipboard = 'unnamedplus'

local vimp = require('vimp')

vimp.nnoremap('k', 'gk')
vimp.nnoremap('j', 'gj')


vimp.inoremap('<Up>', '<NOP>')
vimp.inoremap('<Down>', '<NOP>')
vimp.inoremap('<Left>', '<NOP>')
vimp.inoremap('<Right>', '<NOP>')
vimp.noremap('<Up>', '<NOP>')
vimp.noremap('<Down>', '<NOP>')
vimp.noremap('<Left>', '<NOP>')
vimp.noremap('<Right>', '<NOP>')

-- Appearance
-- ==========

vim.opt.termguicolors = true
vim.cmd[[colorscheme solarized]]
vim.g.rainbow_active = 1

-- Leader commands
-- ===============

vimp.nmap('<leader>w', ':w!<cr>')
vim.cmd[[map <leader>cd :cd %:p:h<cr>:pwd<cr>]]
vimp.map({'silent'}, '<leader><cr>', ':noh<cr>')

-- Search Settings
-- ===============

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Turn Off Swap Files
-- ===================

vim.opt.swapfile = false

-- Indentation and Display
-- =======================

vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = {trail = "·", tab = '  '}

-- Python config
-- =============

vim.g.python3_host_prog = '~/.pyenv/versions/pynvim/bin/python'

-- Folds
-- =====

vim.opt.foldmethod = "syntax" -- Fold based on indent
vim.opt.foldnestmax = 3       -- Deepest fold is 3 levels
vim.opt.foldenable = false    -- Don't fold by default

-- Scrolling
-- =========

vim.opt.scrolloff = 10      -- Start scrolling when we're getting close to margins
vim.opt.sidescrolloff = 15

vim.cmd([[

" Filetype
" ========
"
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *gotmpl set ft=helm

]])

-- ==============
-- Plugin Options
-- ==============
require('Comment').setup()

-- ==============
-- lualine config
-- ==============
require('lualine').setup{
    options = {
        theme = 'solarized',
        extensions = { 'fugitive' }
    },
    sections = {
          lualine_c = { {'filename', path = 1}},
    },
    inactive_sections = {
          lualine_c = { {'filename', path = 1}},
    },
}

-- ===========
-- LSP configs
-- ===========

-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.gopls.setup {}
lspconfig.golangci_lint_ls.setup {}
lspconfig.rls.setup {}
lspconfig.terraformls.setup {}
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.jsonnet_ls.setup {}
lspconfig.groovyls.setup {
    cmd = { "java", "-jar", "/home/jabbadie/tmp/groovy-language-server-all.jar"}
}

lspconfig.helm_ls.setup {
 cmd = { 'helm-ls', 'serve' },
  settings = {
    ['helm-ls'] = {
      yamlls = {
        path = "yaml-language-server",
      }
    }
  }
}
lspconfig.yamlls.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


-- =================
-- nvim-cmp settings
-- =================

local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'treesitter' },
    },
})

require('gitsigns').setup {}
-- ======
-- Golang
-- ======
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').gofmt()
  end,
  group = format_sync_grp,
})


-- =========
-- Terraform
-- =========
vim.api.nvim_exec([[ autocmd BufWritePre *.tf :silent! lua vim.lsp.buf.formatting() ]], false)

require("tmux").setup({
    navigation = {
        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = true,
    },
    resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = true,
    }
})
