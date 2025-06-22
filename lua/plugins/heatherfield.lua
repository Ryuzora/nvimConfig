return {
  'egerhether/heatherfield.nvim',
  config = function()
    require('heatherfield').setup({
      transparent_background = true,
    })
    vim.cmd.colorscheme("heatherfield")
    vim.api.nvim_set_hl(0, 'CursorLine', { underdashed = true })
    vim.api.nvim_set_hl(0, 'Comment', {fg = "#828282"})
  end,
}
-- tess
