-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.solarized-osaka-nvim" },
  { import = "astrocommunity.completion.copilot-cmp" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
}
