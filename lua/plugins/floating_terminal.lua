return {
  -- CRUCIAL: Explicitly tell lazy.nvim this plugin is lazy-loaded.
  lazy = true,

  -- A robust fallback trigger for utility plugins.
  event = "VeryLazy",

  -- Defines the commands that will trigger this plugin to load.
  cmd = { "FloatyOpen", "FloatySmall" },

  config = function()
    local function open_floating_win(opts)
      local width_ratio = opts and opts.width or 0.8
      local height_ratio = opts and opts.height or 0.8

      local ui = vim.api.nvim_list_uis()[1]
      if not ui then
        return
      end

      local win_width = math.floor(ui.width * width_ratio)
      local win_height = math.floor(ui.height * height_ratio)
      local row = math.floor((ui.height - win_height) / 2)
      local col = math.floor((ui.width - win_width) / 2)

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
      })

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
        "🧊 Floaty Window",
        "",
        "Press <Esc> to close.",
      })

      vim.bo[buf].bufhidden = "wipe"
      vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = buf, silent = true })
    end

    vim.api.nvim_create_user_command("FloatyOpen", function()
      open_floating_win()
    end, {})

    vim.api.nvim_create_user_command("FloatySmall", function()
      open_floating_win({ width = 0.5, height = 0.4 })
    end, {})
  end,
}
