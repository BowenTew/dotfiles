-- ============================================================================
-- mason.nvim - LSP/DAP/工具安装器
-- 统一管理外部工具（语言服务器、调试器、linter、formatter）
-- ============================================================================

return {
  "mason-org/mason.nvim",
  build = ":MasonUpdate",
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_uninstalled = "✗",
        package_pending = "⟳",
      },
      border = "rounded",
    },
  },
}
