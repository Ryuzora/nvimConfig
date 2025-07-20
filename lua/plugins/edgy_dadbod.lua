-- In your edgy.nvim plugin file (e.g., /lua/plugins/ui.lua)
return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    -- This is the LazyVim way. We receive the default `opts`
    -- and modify them directly.

    -- 1. Override the 'left' sidebar layout
    opts.left = {
      {
        title = "Neo-Tree",
        ft = "neo-tree",
        pinned = false,
        open = "Neotree",
      },
      {
        title = "Database",
        ft = "dbui",
        pinned = false,
        width = 0.3,
        open = function()
          vim.cmd("DBUI")
        end,
      },
    }

    -- 2. Ensure your bottom bar config is present
    opts.bottom = opts.bottom or {}
    table.insert(opts.bottom, {
      title = "DB Query Result",
      ft = "dbout",
    })
  end,
}
