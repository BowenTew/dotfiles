-- ============================================================================
-- LSP 配置入口
--
-- 在 NvChad 默认的 lspconfig.defaults() 基础上叠加用户定制：
--   * 通配 "*" 注入 workspace.fileOperations 能力
--   * 每个语言服务器一个文件，位于 configs/lsp/<server>.lua
--   * 启用主力语言 server（lua_ls/clangd/gopls/rust_analyzer/ts_ls/vue_ls）
--   * 默认 server（pyright/bashls/...) 走 mason-lspconfig 的 automatic_installation
-- ============================================================================

-- 1. NvChad 内建默认：base46 主题、诊断样式、LspAttach on_attach（gd/gD/D/wa/wr/wl/<leader>ra）
--    以及它自己的 lua_ls workspace.library 注入
require("nvchad.configs.lspconfig").defaults()

-- 2. 通配能力：让 LSP 在文件重命名时同步刷新引用（rename file → update imports）
vim.lsp.config("*", {
  capabilities = {
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    },
  },
})

-- 3. 加载每个 server 的精细配置
local per_server = {
  clangd         = require("configs.lsp.clangd"),
  gopls          = require("configs.lsp.gopls"),
  lua_ls         = require("configs.lsp.lua_ls"),
  rust_analyzer  = require("configs.lsp.rust_analyzer"),
  ts_ls          = require("configs.lsp.ts_ls"),
  vue_ls         = require("configs.lsp.vue_ls"),
}

for name, cfg in pairs(per_server) do
  vim.lsp.config(name, cfg)
end

-- 4. 启用所有 server（精细配置 + ensure_installed 中走默认配置的）
--    注意：mason-lspconfig 的 automatic_enable=true 也会调用 vim.lsp.enable，
--    这里显式 enable 一次确保启动顺序确定。
local servers = {
  -- 精细配置组
  "clangd", "gopls", "lua_ls", "rust_analyzer", "ts_ls", "vue_ls",
  -- 默认配置组（由 NvChad on_attach + capabilities 接管）
  "bashls", "cssls", "dockerls", "eslint",
  "html", "jsonls", "pyright", "svelte", "taplo", "yamlls",
}

vim.lsp.enable(servers)
