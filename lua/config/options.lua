-- editor options
vim.g.autoformat = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.linebreak = true

-- diagnostic options
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
})

-- DBUI
vim.g.db_ui_win_position = "left"

-- diagnostic signs
vim.fn.sign_define("LspError", { text = "✗", texthl = "LspDiagnosticsError" })
vim.fn.sign_define("LspWarning", { text = "⚠", texthl = "LspDiagnosticsWarning" })
vim.fn.sign_define("LspInformation", { text = "ℹ", texthl = "LspDiagnosticsInformation" })
vim.fn.sign_define("LspHint", { text = "➤", texthl = "LspDiagnosticsHint" })

vim.notify("✅ Core Options Loaded", vim.log.levels.INFO)
