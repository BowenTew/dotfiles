-- ============================================================================
-- bufferline.nvim - 顶部 Buffer 标签栏
-- ============================================================================

-- opts = {
--   options = {

--     middle_mouse_command = nil,
--     indicator = {
--       icon = "▎",
--       style = "icon",
--     },
--     buffer_close_icon = "x",
--     modified_icon = "",
--     close_icon = "X",
--     left_trunc_marker = "",
--     right_trunc_marker = "",
--     max_name_length = 24,
--     max_prefix_length = 18,
--     tab_size = 20,
--     diagnostics = "nvim_lsp",
--     diagnostics_update_in_insert = false,
--     diagnostics_indicator = function(count, level)
--       local icon = level:match("error") and " " or " "
--       return " " .. icon .. count
--     end,
--     offsets = {
--       {
--         filetype = "neo-tree",
--         text = "Explorer",
--         text_align = "left",
--         separator = true,
--       },
--     },
--     color_icons = true,
--     show_buffer_icons = true,
--     show_buffer_close_icons = true,
--     show_close_icon = false,
--     show_tab_indicators = true,
--     persist_buffer_sort = true,
--     separator_style = "slant",
--     always_show_bufferline = true,
--     hover = {
--       enabled = false,
--       delay = 150,
--       reveal = {},
--     },
--     sort_by = "insert_after_current",
--   },
-- },
-- config = function(_, opts)
--   vim.opt.termguicolors = true
--   require("bufferline").setup(opts)
-- end,
return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup {
        options = {
          -- bufferline 展示 LSP 诊断信息
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          -- 使用 Nerd Font 图标作为 buffer 的关闭按钮
          buffer_close_icon = "󰅖",
          diagnostics_indicator = function(count, level, diagnostics_dict)
            local s = " "
            -- 这里的 diagnostics_dict 包含了所有级别的计数：error, warning, info, hint
            if diagnostics_dict.error then
              s = s .. " " .. diagnostics_dict.error
            elseif diagnostics_dict.warning then
              s = s .. " " .. diagnostics_dict.warning
            end
            return s
          end,
          close_command = function(n)
            Snacks.bufdelete(n)
          end,
          right_mouse_command = function(n)
            Snacks.bufdelete(n)
          end,
          show_buffer_close_icons = true,
          -- 仅在鼠标 hover 时显示关闭按钮
          hover = {
            enabled = true,
            delay = 150,
            reveal = { "close" },
          },
          separator_style = { "", "" },
          always_show_bufferline = true,
          style_preset = bufferline.style_preset.no_italic,
          numbers = function(opts)
            return string.format("%s", opts.ordinal)
          end,
          custom_filter = function(buf_number)
            -- filter out filetypes you don't want to see
            if vim.bo[buf_number].filetype ~= "qf" then
              return true
            end
          end,
          offsets = {
            {
              filetype = "neo-tree",
              text = "Explorer",
              text_align = "center",
              separator = true,
            },
          },
        },
      }
    end,
    keys = {
      { "<A-1>",       "<cmd>BufferLineGoToBuffer 1<CR>" },
      { "<A-2>",       "<cmd>BufferLineGoToBuffer 2<CR>" },
      { "<A-3>",       "<cmd>BufferLineGoToBuffer 3<CR>" },
      { "<A-4>",       "<cmd>BufferLineGoToBuffer 4<CR>" },
      { "<A-5>",       "<cmd>BufferLineGoToBuffer 5<CR>" },
      { "<A-6>",       "<cmd>BufferLineGoToBuffer 6<CR>" },
      { "<A-7>",       "<cmd>BufferLineGoToBuffer 7<CR>" },
      { "<A-8>",       "<cmd>BufferLineGoToBuffer 8<CR>" },
      { "<A-9>",       "<cmd>BufferLineGoToBuffer 9<CR>" },
      -- 导航
      { "[b",           "<cmd>BufferLineCyclePrev<CR>",               desc = "Previous buffer" },
      { "]b",           "<cmd>BufferLineCycleNext<CR>",               desc = "Next buffer" },
      -- 关闭
      { "<Leader>bd",  function() Snacks.bufdelete() end,              desc = "Close current" },
      { "<Leader>bD",  "<cmd>bdelete!<CR>",                           desc = "Force close" },
      { "<Leader>bl",  "<cmd>BufferLineCloseLeft<CR>",               desc = "Close Left" },
      { "<Leader>br",  "<cmd>BufferLineCloseRight<CR>",              desc = "Close Right" },
      -- 移动
      { "<Leader>bb",  "<cmd>BufferLineMovePrev<CR>",                desc = "Move back" },
      { "<Leader>bn",  "<cmd>BufferLineMoveNext<CR>",                desc = "Move next" },
      -- 选择 & 固定
      { "<Leader>bp",  "<cmd>BufferLinePick<CR>",                    desc = "Pick Buffer" },
      { "<Leader>bP",  "<cmd>BufferLineTogglePin<CR>",               desc = "Pin/Unpin Buffer" },
      -- 排序
      { "<Leader>bsd", "<cmd>BufferLineSortByDirectory<CR>",         desc = "Sort by directory" },
      { "<Leader>bse", "<cmd>BufferLineSortByExtension<CR>",         desc = "Sort by extension" },
      { "<Leader>bsr", "<cmd>BufferLineSortByRelativeDirectory<CR>", desc = "Sort by relative dir" },
    }
  }
}
