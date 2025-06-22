-- import utils config
local utils = require("config.utils")

-- Keybind for running code
vim.keymap.set("n", "<leader><CR>", utils.coderun, { noremap = true, silent = true, desc = "Save and Run Code" })
vim.keymap.set("n", "<leader>.<CR>", utils.folderrun, { noremap = true, silent = true, desc = "Save and Compile Folder" })

-- General keymaps
vim.keymap.set("i", "<C-l>", "<CR><Esc>o", { noremap = true, silent = true, desc = "New line below" })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy to clipboard" })
vim.keymap.set("n", "dx", "dd", { noremap = true, silent = true, desc = "Cut line (alternative)" })
vim.keymap.set("n", "dd", '"_dd', { noremap = true, silent = true, desc = "Delete line without yanking" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })

-- Macro and quit improvements
vim.keymap.set("n", "m", "q", { noremap = true, desc = "Start macro recording (replaces default q)" })
vim.keymap.set("n", "qq", "<cmd>q<cr>", { noremap = true, desc = "Quit window" })
vim.keymap.set("n", "qb", "<cmd>bdelete<cr>", { noremap = true, desc = "Close buffer" })

vim.notify("✅ Keymaps config loaded", vim.log.levels.INFO)
