return {
  {
    dir = vim.fn.stdpath("config"),
    name = "autosave",
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*:n",
        callback = function()
          if vim.bo.modified and vim.bo.filetype ~= "" then
            vim.cmd("silent! write")
          end
        end,
      })
    end,
  },
}
