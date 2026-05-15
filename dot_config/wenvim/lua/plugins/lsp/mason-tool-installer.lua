return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  event = "VeryLazy",  -- 在启动后延迟加载
  opts = {
    ensure_installed = {
      "luacheck",
      "eslint_d",
      -- 可以按需再加一些常用 LSP / 工具，例如：
      -- "gopls",
      -- "lua_ls",
      -- "rust_analyzer",
      -- "typescript-language-server",
    },
    run_on_start = true,
    start_delay = 3000,
    auto_update = false,
  },
}