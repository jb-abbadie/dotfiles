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
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
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

" ==============
" Plugin Options
" ==============

" Telescope
" =========
map <C-p> :Telescope find_files<CR>
map <C-g> :Telescope live_grep<CR>
nnoremap <leader>ff :Telescope grep_string<CR>

]])

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

--local configs = require 'lspconfig/configs'
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-o>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}


local nvim_lsp = require('lspconfig')
local servers = { "gopls", "golangci_lint_ls", "rls", "terraformls", "pyright" , "tsserver", "jsonnet_ls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

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
    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

            -- set a name for each source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                path = "[Path]",
                treesitter = "[TS]",
            })[entry.source.name]
            return vim_item
        end,
    },
})

-- =================
-- Treesitter config
-- =================
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    },
}


-- ======
-- Golang
-- ======
require('go').setup()

vim.api.nvim_exec([[ autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil,500) ]], false)
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)


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
