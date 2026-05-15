-- ============================================================================
-- conform.nvim - 格式化器配置
-- 触发：保存时自动格式化（500ms 超时，失败回退到 LSP format）
-- 手动：<leader>fm（NvChad 自带键位，已绑定 conform.format）
-- ============================================================================

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    vue = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    -- 全文件类型兜底：去除行尾空白
    ["_"] = { "trim_whitespace" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
