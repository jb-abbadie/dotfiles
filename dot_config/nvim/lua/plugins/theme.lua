return {
  {
    'ishan9299/nvim-solarized-lua',
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme solarized]])
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      {
        theme = 'solarized',
        extensions = { 'fugitive' }
      },
      sections = {
        lualine_c = { {'filename', path = 1}},
      },
      inactive_sections = {
        lualine_c = { {'filename', path = 1}},
      },
    },
  },
  'nvim-tree/nvim-web-devicons',
  {
    'stevearc/dressing.nvim',
    opts = {}
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = { indent = {char="▏"}} },
  {'lewis6991/gitsigns.nvim', opts = {} },
}
