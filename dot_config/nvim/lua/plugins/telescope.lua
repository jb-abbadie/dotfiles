return {
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
}
