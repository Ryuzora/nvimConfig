vim.cmd("highlight clear")
vim.o.background = "dark" -- or "light"

vim.g.colors_name = "Ryuzora"

-- Basic highlights
vim.api.nvim_set_hl(0, "Normal", { fg = "#f7768e", bg = "#331a40" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#f7768e", bg = "#331a40" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f7768e", bg = "#3b2770", bold = true })
vim.api.nvim_set_hl(0, "Visual", { bg = "#33467C" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#565f89", italic = true })
