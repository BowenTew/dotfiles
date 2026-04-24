-- ============================================================================
-- 编辑器增强插件入口
-- ============================================================================

return {
  { import = "plugins.editor.treesitter" },
  { import = "plugins.editor.autopairs" },
  { import = "plugins.editor.comment" },
  { import = "plugins.editor.surround" },
  { import = "plugins.editor.indentline" },
  { import = "plugins.editor.flash" },
  { import = "plugins.editor.multicursors" },
  { import = "plugins.editor.hlslens" },
  { import = "plugins.editor.rainbow-delimiters" },
  { import = "plugins.editor.todo-comments" },
  { import = "plugins.editor.blink-cmp" },
}
