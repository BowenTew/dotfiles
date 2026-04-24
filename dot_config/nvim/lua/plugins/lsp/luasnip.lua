-- ============================================================================
-- LuaSnip - 代码片段引擎
-- 支持 VSCode 格式代码片段
-- ============================================================================

return {
  "L3MON4D3/LuaSnip",
  lazy = true,
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
