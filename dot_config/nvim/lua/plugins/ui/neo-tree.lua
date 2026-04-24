-- ============================================================================
-- neo-tree.nvim - 文件树浏览器
-- 比 nvim-tree 更现代，支持 Git、诊断、悬浮等多种视图
-- ============================================================================

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer Toggle" },
    { "<leader>o", "<cmd>Neotree focus<cr>", desc = "Explorer Focus" },
    { "<leader>ge", "<cmd>Neotree git_status<cr>", desc = "Explorer Git Status" },
    { "<leader>be", "<cmd>Neotree buffers<cr>", desc = "Explorer Buffers" },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = false,
    sort_function = nil,
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        with_expanders = nil,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = AeonVim.icons.folder.closed,
        folder_open = AeonVim.icons.folder.open,
        folder_empty = AeonVim.icons.folder.empty,
        default = "*",
        highlight = "NeoTreeFileIcon",
      },
      modified = {
        symbol = AeonVim.icons.git.modified,
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          added = AeonVim.icons.git.added,
          modified = AeonVim.icons.git.modified,
          deleted = AeonVim.icons.git.deleted,
          renamed = AeonVim.icons.git.renamed,
          untracked = AeonVim.icons.git.untracked,
          ignored = AeonVim.icons.git.ignored,
          unstaged = AeonVim.icons.git.unstaged,
          staged = AeonVim.icons.git.staged,
          conflict = AeonVim.icons.git.conflict,
        },
      },
    },
    window = {
      position = "left",
      width = 35,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<space>"] = {
          "toggle_node",
          nowait = false,
        },
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["<esc>"] = "revert_preview",
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["l"] = "focus_preview",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["t"] = "open_tabnew",
        ["w"] = "open_with_window_picker",
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        ["Z"] = "expand_all_nodes",
        ["a"] = {
          "add",
          config = {
            show_path = "none",
          },
        },
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy",
        ["m"] = "move",
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
        ["i"] = "show_file_details",
      },
    },
    nesting_rules = {},
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true,
        hide_by_name = {
          "node_modules",
        },
        hide_by_pattern = {},
        always_show = {},
        never_show = {},
        never_show_by_pattern = {},
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      group_empty_dirs = false,
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = false,
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["#"] = "fuzzy_sorter",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["og"] = { "order_by_git_status", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
        fuzzy_finder_mappings = {
          ["<down>"] = "move_cursor_down",
          ["<C-n>"] = "move_cursor_down",
          ["<up>"] = "move_cursor_up",
          ["<C-p>"] = "move_cursor_up",
        },
      },
    },
    buffers = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      group_empty_dirs = true,
      show_unloaded = true,
      window = {
        mappings = {
          ["bd"] = "buffer_delete",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
      },
    },
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
          ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)

    -- 自动关闭当最后一个窗口时
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("NeoTreeClose", { clear = true }),
      pattern = "*",
      callback = function()
        local wins = vim.api.nvim_list_wins()
        local count = 0
        for _, win in ipairs(wins) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.api.nvim_buf_get_option(buf, "filetype")
          if ft ~= "neo-tree" then
            count = count + 1
          end
        end
        if count == 0 then
          vim.cmd("quit")
        end
      end,
    })
  end,
}
