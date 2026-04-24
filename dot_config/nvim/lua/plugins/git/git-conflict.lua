-- ============================================================================
-- Git Conflict - 冲突解决辅助
-- 高亮冲突标记，提供快速选择命令
-- ============================================================================

return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = { "BufReadPost", "BufNewFile" },
  enabled = true,
  opts = {
    default_mappings = true,
    default_commands = true,
    disable_diagnostics = false,
    list_opener = "copen",
    highlights = {
      incoming = "DiffAdd",
      current = "DiffText",
    },
  },
  keys = {
    { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Git Conflict: Choose Ours" },
    { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Git Conflict: Choose Theirs" },
    { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Git Conflict: Choose Both" },
    { "<leader>gc0", "<cmd>GitConflictChooseNone<cr>", desc = "Git Conflict: Choose None" },
    { "<leader>gcn", "<cmd>GitConflictNextConflict<cr>", desc = "Git Conflict: Next" },
    { "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", desc = "Git Conflict: Previous" },
    { "<leader>gcl", "<cmd>GitConflictListQf<cr>", desc = "Git Conflict: List" },
  },
}
