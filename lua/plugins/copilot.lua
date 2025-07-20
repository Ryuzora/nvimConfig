return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "github/copilot.vim" },
    { "nvim-lua/plenary.nvim", branch = "master" },
  },
  build = "make tiktoken",
  opts = {
    prompts = {
      RenameVariable = {
        prompt = "Rename variables in given selection based on context",
        selection = function(selected)
          local select = require("CopilotChat.select")
          return select.visual(selected)
        end,
      },
    },
  },
  keys = {
    { "<leader>.zc", "<cmd>CopilotChat<cr>", mode = "n", desc = "Open Copilot Chat"},
    { "<leader>.ze", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "Explain Code"},
    { "<leader>.zr", "<cmd>CopilotChatReview", mode = "v", desc = "Review Code"},
    { "<leader>.zf", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "Fix Code"},
    { "<leader>.zo", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "Optimize Code"},
    { "<leader>.zd", "<cmd>CopilotChatDocs<cr>", mode = "v", desc = "Generate Docs"},
    { "<leader>.zt", "<cmd>CopilotChatTests<cr>", mode = "v", desc = "Generate tests"},
    { "<leader>.zm", "<cmd>CopilotChatCommit<cr>", mode = "n", desc = "Generate commit message"},
    { "<leader>.zM", "<cmd>CopilotChatCommit<cr>", mode = "v", desc = "Generate commit message for selection"},
    { "<leader>.zv", "<cmd>CopilotChatRenameVariable<cr>", mode = "v", desc = "Rename variables name based on context"},
  }
}
