-- ============================================================================
-- multicursors.nvim - 多光标编辑
-- 同时编辑多处相同文本
-- ============================================================================

return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  dependencies = {
    "smoka7/hydra.nvim",
  },
  opts = {},
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  keys = {
    {
      mode = { "v", "n" },
      "<Leader>m",
      "<cmd>MCstart<cr>",
      desc = "Create a selection for selected text or word under the cursor",
    },
  },
}
