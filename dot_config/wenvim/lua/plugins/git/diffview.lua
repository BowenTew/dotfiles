-- ============================================================================
-- Diffview - 强大的 Diff 查看器
-- 查看工作区与 index 的差异、分支对比、文件历史等
--
-- 全局快捷键：
--   <leader>gdo   打开 Diffview（工作区 vs index）
--   <leader>gdc   关闭 Diffview
--   <leader>gdh   查看整个仓库的提交历史
--   <leader>gdH   查看当前文件的提交历史
--
-- Diff 视图内快捷键：
--   <tab>/<s-tab>  切换到下一个/上一个文件
--   gf             跳转到源文件
--   <C-w><C-f>     分屏打开源文件
--   <leader>e      聚焦文件面板
--   <leader>b      切换文件面板显示/隐藏
--   g<C-x>         循环切换布局
--
-- 冲突解决（Diff 视图内）：
--   [x / ]x        上一个/下一个冲突
--   <leader>co     选择 ours（当前分支）
--   <leader>ct     选择 theirs（目标分支）
--   <leader>cb     选择 base（共同祖先）
--   <leader>ca     选择 all（保留全部）
--   dx             选择 none（删除冲突块）
--
-- 三路合并（diff3）：
--   2do            获取 ours 的修改
--   3do            获取 theirs 的修改
--
-- 文件面板快捷键：
--   j/k            上下移动
--   o / 双击       打开文件 diff
--   -              暂存/取消暂存当前文件（git add/reset）
--   S              暂存全部（git add -A）
--   U              取消暂存全部
--   X              还原文件（git restore）
--   R              刷新文件列表
--   L              查看提交日志
--   i              切换列表/树视图
--   f              切换目录折叠
--
-- 文件历史面板快捷键：
--   o / 双击       打开选中提交的 diff
--   y              复制 commit hash
--   L              查看提交日志
--   g!             打开选项面板
--   <C-A-d>        在 Diffview 中打开
--   zR / zM        展开/收起全部折叠
-- ============================================================================

return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  keys = {
    { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Git Diffview Open" },
    { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Git Diffview Close" },
    { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "Git File History" },
    { "<leader>gdH", "<cmd>DiffviewFileHistory %<cr>", desc = "Git File History (current)" },
  },
  opts = {
    diff_binaries = false,
    enhanced_diff_hl = false,
    git_cmd = { "git" },
    hg_cmd = { "hg" },
    use_icons = true,
    show_help_hints = true,
    watch_index = true,
    icons = {
      folder_closed = AeonVim.icons.folder.closed,
      folder_open = AeonVim.icons.folder.open,
    },
    signs = {
      fold_closed = AeonVim.icons.arrow.right,
      fold_open = AeonVim.icons.arrow.down,
      done = AeonVim.icons.ui.check,
    },
    view = {
      default = {
        winbar_info = false,
      },
      merge_tool = {
        layout = "diff3_horizontal",
        disable_diagnostics = true,
        winbar_info = true,
      },
      file_history = {
        winbar_info = false,
      },
    },
    file_panel = {
      listing_style = "tree",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
      win_config = {
        position = "left",
        width = 35,
        win_opts = {},
      },
    },
    file_history_panel = {
      log_options = {
        git = {
          single_file = {
            diff_merges = "combined",
          },
          multi_file = {
            diff_merges = "first-parent",
          },
        },
        hg = {
          single_file = {},
          multi_file = {},
        },
      },
      win_config = {
        position = "bottom",
        height = 16,
        win_opts = {},
      },
    },
    commit_log_panel = {
      win_config = {},
    },
    default_args = {
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },
    hooks = {},
    keymaps = {
      disable_defaults = false,
      view = {
        ["<tab>"] = function()
          require("diffview.actions").select_next_entry()
        end,
        ["<s-tab>"] = function()
          require("diffview.actions").select_prev_entry()
        end,
        ["gf"] = function()
          require("diffview.actions").goto_file()
        end,
        ["<C-w><C-f>"] = function()
          require("diffview.actions").goto_file_split()
        end,
        ["<C-w>gf"] = function()
          require("diffview.actions").goto_file_tab()
        end,
        ["<leader>e"] = function()
          require("diffview.actions").focus_files()
        end,
        ["<leader>b"] = function()
          require("diffview.actions").toggle_files()
        end,
        ["g<C-x>"] = function()
          require("diffview.actions").cycle_layout()
        end,
        ["[x"] = function()
          require("diffview.actions").prev_conflict()
        end,
        ["]x"] = function()
          require("diffview.actions").next_conflict()
        end,
        ["<leader>co"] = function()
          require("diffview.actions").conflict_choose("ours")
        end,
        ["<leader>ct"] = function()
          require("diffview.actions").conflict_choose("theirs")
        end,
        ["<leader>cb"] = function()
          require("diffview.actions").conflict_choose("base")
        end,
        ["<leader>ca"] = function()
          require("diffview.actions").conflict_choose("all")
        end,
        ["dx"] = function()
          require("diffview.actions").conflict_choose("none")
        end,
      },
      diff1 = {},
      diff2 = {},
      diff3 = {
        { { "n", "x" }, "2do", function()
          require("diffview.actions").diffget("ours")
        end },
        { { "n", "x" }, "3do", function()
          require("diffview.actions").diffget("theirs")
        end },
      },
      diff4 = {
        { { "n", "x" }, "1do", function()
          require("diffview.actions").diffget("base")
        end },
        { { "n", "x" }, "2do", function()
          require("diffview.actions").diffget("ours")
        end },
        { { "n", "x" }, "3do", function()
          require("diffview.actions").diffget("theirs")
        end },
      },
      file_panel = {
        ["j"] = function()
          require("diffview.actions").next_entry()
        end,
        ["<down>"] = function()
          require("diffview.actions").next_entry()
        end,
        ["k"] = function()
          require("diffview.actions").prev_entry()
        end,
        ["<up>"] = function()
          require("diffview.actions").prev_entry()
        end,
        ["o"] = function()
          require("diffview.actions").select_entry()
        end,
        ["<2-LeftMouse>"] = function()
          require("diffview.actions").select_entry()
        end,
        ["-"] = function()
          require("diffview.actions").toggle_stage_entry()
        end,
        ["S"] = function()
          require("diffview.actions").stage_all()
        end,
        ["U"] = function()
          require("diffview.actions").unstage_all()
        end,
        ["X"] = function()
          require("diffview.actions").restore_entry()
        end,
        ["R"] = function()
          require("diffview.actions").refresh_files()
        end,
        ["L"] = function()
          require("diffview.actions").open_commit_log()
        end,
        ["<C-b>"] = function()
          require("diffview.actions").scroll_view(-0.25)
        end,
        ["<C-f>"] = function()
          require("diffview.actions").scroll_view(0.25)
        end,
        ["<tab>"] = function()
          require("diffview.actions").select_next_entry()
        end,
        ["<s-tab>"] = function()
          require("diffview.actions").select_prev_entry()
        end,
        ["gf"] = function()
          require("diffview.actions").goto_file()
        end,
        ["<C-w><C-f>"] = function()
          require("diffview.actions").goto_file_split()
        end,
        ["<C-w>gf"] = function()
          require("diffview.actions").goto_file_tab()
        end,
        ["i"] = function()
          require("diffview.actions").listing_style()
        end,
        ["f"] = function()
          require("diffview.actions").toggle_flatten_dirs()
        end,
        ["<leader>e"] = function()
          require("diffview.actions").focus_files()
        end,
        ["<leader>b"] = function()
          require("diffview.actions").toggle_files()
        end,
        ["g<C-x>"] = function()
          require("diffview.actions").cycle_layout()
        end,
        ["[x"] = function()
          require("diffview.actions").prev_conflict()
        end,
        ["]x"] = function()
          require("diffview.actions").next_conflict()
        end,
      },
      file_history_panel = {
        ["g!"] = function()
          require("diffview.actions").options()
        end,
        ["<C-A-d>"] = function()
          require("diffview.actions").open_in_diffview()
        end,
        ["y"] = function()
          require("diffview.actions").copy_hash()
        end,
        ["L"] = function()
          require("diffview.actions").open_commit_log()
        end,
        ["zR"] = function()
          require("diffview.actions").open_all_folds()
        end,
        ["zM"] = function()
          require("diffview.actions").close_all_folds()
        end,
        ["j"] = function()
          require("diffview.actions").next_entry()
        end,
        ["<down>"] = function()
          require("diffview.actions").next_entry()
        end,
        ["k"] = function()
          require("diffview.actions").prev_entry()
        end,
        ["<up>"] = function()
          require("diffview.actions").prev_entry()
        end,
        ["o"] = function()
          require("diffview.actions").select_entry()
        end,
        ["<2-LeftMouse>"] = function()
          require("diffview.actions").select_entry()
        end,
        ["<C-b>"] = function()
          require("diffview.actions").scroll_view(-0.25)
        end,
        ["<C-f>"] = function()
          require("diffview.actions").scroll_view(0.25)
        end,
        ["<tab>"] = function()
          require("diffview.actions").select_next_entry()
        end,
        ["<s-tab>"] = function()
          require("diffview.actions").select_prev_entry()
        end,
        ["gf"] = function()
          require("diffview.actions").goto_file()
        end,
        ["<C-w><C-f>"] = function()
          require("diffview.actions").goto_file_split()
        end,
        ["<C-w>gf"] = function()
          require("diffview.actions").goto_file_tab()
        end,
        ["<leader>e"] = function()
          require("diffview.actions").focus_files()
        end,
        ["<leader>b"] = function()
          require("diffview.actions").toggle_files()
        end,
        ["g<C-x>"] = function()
          require("diffview.actions").cycle_layout()
        end,
      },
      option_panel = {
        ["<tab>"] = function()
          require("diffview.actions").select_entry()
        end,
        ["q"] = function()
          require("diffview.actions").close()
        end,
      },
    },
  },
}
