return {
  { import = "plugins.finder" },
  { import = "plugins.git" },
  { import = "plugins.ui" },
  { import = "plugins.lsp" },
  { import = "plugins.editor" },
  { import = "plugins.base" },
  -- { import = "plugins.languages" },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
      options = { "buffers", "curdir", "tabpages", "winsize" },
      pre_save = nil,
      save_empty = false,
    },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}
