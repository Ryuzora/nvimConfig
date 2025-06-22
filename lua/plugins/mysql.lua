return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    -- The core database backend
    { 'tpope/vim-dadbod', lazy = true },
    
    -- Provides completion, still useful for native omnicompletion without nvim-cmp
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
    'DBUIClose',
  },
  init = function()
    -- These settings are great, let's keep them.
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_save_location = vim.fn.stdpath('config') .. require("plenary.path").path.sep .. "db_ui"
  end,

  config = function()
    -- This autocmd is the key for completion without nvim-cmp.
    -- It sets up omnicompletion, which you can trigger in SQL buffers
    -- with <C-x><C-o> in Insert mode.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql", "mysql", "plsql" },
      command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
      desc = "Enable dadbod omnicompletion",
    })

    -- This is a nice quality-of-life improvement for navigating the DBUI window.
    -- It makes navigation feel more like a standard file tree.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dbui",
      callback = function()
        vim.schedule(function()
          local opts = { buffer = true, noremap = true, silent = true }
          -- Map 'l' or <Enter> to open/expand a node
          vim.keymap.set("n", "l", "<CR>", opts)
          -- Map 'h' to close/collapse a node
          vim.keymap.set("n", "h", "-", opts)
        end)
      end,
      desc = "Set DBUI custom keymaps",
    })
  end,

  keys = {
    -- A simple, direct toggle for the UI.
    { "<leader>du", "<cmd>DBUIToggle<CR>", desc = " DBUI Toggle" },

    -- A key to quickly close the UI and any associated query buffers.
    -- The `bd!` command force-closes the current buffer, which is useful
    -- for getting rid of the query buffer that DBUIToggle might leave you in.
    { "<leader>dq", "<cmd>DBUIClose<CR><cmd>bd!<CR>", desc = " DBUI Quit" },
  }
}
