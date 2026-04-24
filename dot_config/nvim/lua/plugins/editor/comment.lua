-- ============================================================================
-- Comment.nvim - 智能代码注释
--
-- 快捷键:
--   gcc       → 注释/取消注释当前行
--   gbc       → 块注释/取消注释当前行
--   gc{motion}→ 注释范围 (gc3j = 注释3行, gcap = 注释整段)
--   gb{motion}→ 块注释范围
--   gc / gb   → Visual 模式下注释选中区域
--
-- 依赖 nvim-ts-context-commentstring 实现上下文感知:
-- 在 Vue/JSX/TSX 等混合语言文件中自动选择正确的注释符号
-- (HTML 区域用 <!--  -->, JS 区域用 //, CSS 区域用 /* */)
-- ============================================================================

return {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        toggler = {
          line = "gcc",
          block = "gbc",
        },
        opleader = {
          line = "gc",
          block = "gb",
        },
      })
    end,
}
