-- ~/.config/nvim/lua/plugins/cmp-load-fix.lua

return {
  --[[
    This is a more forceful fix for the "cmp not found" error.
    It finds the nvim-cmp plugin and forces it to load on startup
    by setting lazy=false. This ensures it's always available for
    other plugins that depend on it.
  --]]
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
  },
}
