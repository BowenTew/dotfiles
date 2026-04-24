return {
  "folke/noice.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    messages = { 
      enabled = true,  -- 改为 true
      view = "mini",   -- 使用 mini 视图，更紧凑
    },
    cmdline = {
      enabled = true,
      view = "cmdline_popup",  -- 命令行用弹窗
    },
    notify = {
      enabled = true,
      view = "notify",
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
        ["vim.lsp.util.stylize_markdown"] = false,
        ["cmp.entry.get_documentation"] = true,
      },
      progress = { enabled = false },
      hover = { enabled = false },
    },
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
  },
}