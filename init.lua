-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("mason").setup()
-- require("colors.oh-lucy-evening")
require("mini.icons").setup()
require("plugins.debugger")
require("config.neotree-keys")

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.wrap = true
vim.opt.linebreak = false

-- Mason LSP setup
require("mason-lspconfig").setup({
  ensure_installed = { "tsserver", "pyright", "clangd", "emmet_ls" },
})

local lspconfig = require("lspconfig")

-- Setup Emmet (here’s the fix)
lspconfig.emmet_ls.setup({
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "svelte",
    "vue",
    "astro",
  },
  init_options = {
    html = {
    options = {
        ["block_element_tags"] = "*",
        ["pretty_break"] = true,
        ["show_abbreviation_preview"] = true,
      },
    },
  },
})
-- Which-Key custom bindings
local wk = require("which-key")
wk.add({
  { "<leader>.", group = "User Created Menu" },
  { "<leader>.d", ':normal! gg"edG<cr>', desc = "Delete All Lines", icon = {name ='mason', cat='filetype', color = 'purple'} },
  { "<leader>.r", '<cmd>LiveServerToggle<cr>', desc = "Toggle Live Server", icon = {name ='mason', cat='filetype', color = 'purple'} },
  { "<leader>.y", ":%y+<cr>", desc = "Copy All Lines", icon = {name = 'lazy',cat = 'filetype', color = 'purple'} },
  { "<leader>.x", ":!mkdir executables<cr>", desc = 'Create "executables" dir'},
  { "<leader>.q", ":wqa<cr>", desc = "Save And Quit Neovim" },
  { "<leader>.w", "w", desc = "Save File", icon = { name = 'ubuntu', cat = 'os',color='purple'} },
  { "<leader>.l", "<leader>sl", desc = "Load Last Session", icon = { name = "lazy", cat = 'filetype', color = 'purple'}},
})

-- Configure Pyright
lspconfig.pyright.setup({})

-- Configure Clangd
lspconfig.clangd.setup({
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
  settings = {
    clangd = {
      -- Add any specific clangd settings here
    },
  },
  on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

    vim.fn.sign_define("LspError", { text = "✗", texthl = "LspDiagnosticsError" })
    vim.fn.sign_define("LspWarning", { text = "⚠", texthl = "LspDiagnosticsWarning" })
    vim.fn.sign_define("LspInformation", { text = "ℹ", texthl = "LspDiagnosticsInformation" })
    vim.fn.sign_define("LspHint", { text = "➤", texthl = "LspDiagnosticsHint" })
  end,
})

local function coderun()
  vim.cmd("write")

  local file = vim.fn.expand("%")
  local filetype = vim.bo.filetype

  if filetype == "python" then
    vim.cmd("split | terminal python " .. file)
  elseif filetype == "javascript" then
    vim.cmd("split | terminal node " .. file)
  elseif filetype == "c" then
    local output = vim.fn.expand("%:r")
    vim.cmd("!gcc " .. file .. " -o ./executables/" .. output)
    vim.cmd("split | terminal ./executables/" .. output)
  elseif filetype == "cpp" then
    local output_cpp = vim.fn.expand("%:r")
    vim.cmd("!g++ " .. file .. " -o ./executables/" .. output_cpp)
    vim.cmd("split | terminal ./executables/" .. output_cpp)
  end

  vim.cmd("autocmd termOpen * setlocal nowrap")
end

local function folderrun()
  vim.cmd("write")

  local file = vim.fn.expand("%")
  local filetype = vim.bo.filetype

  if filetype == "python" then
    vim.cmd("split | terminal python " .. file)
  elseif filetype == "javascript" then
    vim.cmd("split | terminal node " .. file)
  elseif filetype == "c" then
    local output = vim.fn.expand("%:r")
    vim.cmd("!gcc " .. file .. " -o ./executables/" .. output)
    vim.cmd("split | terminal ./executables/" .. output)
  elseif filetype == "cpp" then
    local output_cpp = vim.fn.expand("%:r")
    vim.cmd("!g++ *.cpp -o ./executables/" .. output_cpp)
    vim.cmd("split | terminal ./executables/" .. output_cpp)
  end

  vim.cmd("autocmd termOpen * setlocal nowrap")
end

-- Diagnostic visuals
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
})

-- Keybind for running code
vim.keymap.set("n", "<leader><CR>", coderun, { noremap = true, silent = true, desc = "Save And Run Code" })
vim.keymap.set("n", "<leader>.<CR>", folderrun, { noremap = true, silent = true, desc = "Save And Run Code in Current Folder" })
vim.keymap.set("i", "<c-l>", "<cr><esc>o", {noremap= true, silent=true})
vim.keymap.set("v", "<leader>y",'"+y',{noremap = true, silent = true, desc = "Copy to clipboard"} )
vim.keymap.set("n", "dx", 'dd', { noremap = true, silent=true})
vim.keymap.set("n", "dd", '"_dd', { noremap = true, silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n>", { noremap = true, silent = true })
