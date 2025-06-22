-- which-key config

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      -- your which-key setup options
    })
    vim.notify("✅ Which-key config loaded", vim.log.levels.info)

    local wk = require("which-key")
    wk.add({
      { "<leader>.", group = "User Created Menu" },
      { "<leader>.d", ':normal! gg"_dG<cr>', desc = "Delete All Lines (No Yank)", icon = "" },
      { "<leader>.r", "<cmd>LiveServerToggle<cr>", desc = "Toggle Live Server", icon = "" },
      { "<leader>.y", ":%y+<cr>", desc = "Copy All Lines", icon = "" },
      { "<leader>.q", ":wqa<cr>", desc = "Save and Quit All", icon = "" },
      { "<leader>.w", "<cmd>w<cr>", desc = "Save File", icon = "" },
      { "<leader>.l", "<leader>sl", desc = "Load Last Session", icon = "" },
    })
  end,
}
