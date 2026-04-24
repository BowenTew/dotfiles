return {
  ["*"] = {
    capabilities = {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    },
  },

  clangd = require("config.lsp.clangd"),
  gopls = require("config.lsp.go"),
  lua_ls = require("config.lsp.lua_ls"),
  rust_analyzer = require("config.lsp.rust"),
  ts_ls = require("config.lsp.typescript"),
  vue_ls = require("config.lsp.vue"),
}
