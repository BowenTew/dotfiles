-- Lua LSP（在 NvChad 默认 lua_ls 配置基础上叠加）
-- NvChad 的 lspconfig.defaults() 已经为 lua_ls 注入了 workspace.library（含 nvchad_types、lazy 等），
-- 这里通过同名 vim.lsp.config 二次扩展，仅追加 wenvim 风格的偏好。
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json", ".luarc.jsonc",
    ".luacheckrc", ".stylua.toml", "stylua.toml",
    ".git",
  },
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      codeLens = { enable = true },
      completion = { callSnippet = "Replace" },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
    },
  },
}
