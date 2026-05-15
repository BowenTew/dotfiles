-- ============================================================================
-- LSP 配置入口
-- 包含：LSP 服务器、补全、格式化、代码检查
-- ============================================================================

return {
  { import = "plugins.lsp.mason" },
  { import = "plugins.lsp.lspconfig" },
  { import = "plugins.lsp.mason-lspconfig" },
  { import = "plugins.lsp.mason-tool-installer" },
  { import = "plugins.lsp.luasnip" },
  { import = "plugins.lsp.conform" },
  { import = "plugins.lsp.lint" },
}