-- ============================================================================
-- Git 插件入口
-- 导入所有 Git 相关插件配置
-- ============================================================================

return {
  { import = "plugins.git.gitsigns" },
  { import = "plugins.git.diffview" },
  { import = "plugins.git.lazygit" },
  { import = "plugins.git.git-conflict" },
}
