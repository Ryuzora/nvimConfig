return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    vim.notify("✅ LSP configs loaded", vim.log.levels.INFO)

    -- Setup mason so it can manage external tooling
    mason.setup()

    -- Ensure the servers specified here are installed
    mason_lspconfig.setup({
      ensure_installed = { "pyright", "clangd", "emmet_ls" },
    })

    -- A general on_attach function to apply to all servers
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      -- Add other keymaps or capabilities here if you want them for all servers
    end

    -- Setup for each LSP server
    local servers = {
      pyright = {},
      clangd = {
        -- You can keep specific settings here if needed
        -- The general on_attach will apply, plus any specific ones
      },
      tsserver = {},
      emmet_ls = {
        filetypes = {
          "html", "css", "scss", "javascript", "javascriptreact",
          "typescriptreact", "svelte", "vue", "astro",
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
      },
    }

    -- Loop through servers and set them up
    for server_name, config in pairs(servers) do
      -- Ensure on_attach is a function
      config.on_attach = on_attach
      lspconfig[server_name].setup(config)
    end
  end,
}
