-- ============================================================================
-- Gitsigns - 行内 Git 标记
-- 显示修改、添加、删除的行内标记，支持 stage/reset 等操作
-- ============================================================================

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    signs = {
      add = { text = AeonVim.icons.git.added },
      change = { text = AeonVim.icons.git.changed },
      delete = { text = AeonVim.icons.git.deleted },
      topdelete = { text = AeonVim.icons.git.deleted },
      changedelete = { text = AeonVim.icons.git.changed },
      untracked = { text = AeonVim.icons.git.untracked },
    },
    signs_staged = {
      add = { text = AeonVim.icons.git.added },
      change = { text = AeonVim.icons.git.changed },
      delete = { text = AeonVim.icons.git.deleted },
      topdelete = { text = AeonVim.icons.git.deleted },
      changedelete = { text = AeonVim.icons.git.changed },
    },
    signs_staged_enable = true,
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
      use_focus = true,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- Navigation
      map("n", "]g", gs.next_hunk, "Next Git Hunk")
      map("n", "[g", gs.prev_hunk, "Prev Git Hunk")

      -- Actions
      map("n", "<leader>gs", gs.stage_hunk, "Git Stage Hunk")
      map("n", "<leader>gr", gs.reset_hunk, "Git Reset Hunk")
      map("v", "<leader>gs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Git Stage Hunk")
      map("v", "<leader>gr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Git Reset Hunk")
      map("n", "<leader>gS", gs.stage_buffer, "Git Stage Buffer")
      map("n", "<leader>gR", gs.reset_buffer, "Git Reset Buffer")
      map("n", "<leader>gu", gs.undo_stage_hunk, "Git Undo Stage Hunk")
      map("n", "<leader>gp", gs.preview_hunk, "Git Preview Hunk")
      map("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, "Git Blame Line")
      map("n", "<leader>gB", gs.toggle_current_line_blame, "Git Toggle Line Blame")
      map("n", "<leader>gd", gs.diffthis, "Git Diff This")
      map("n", "<leader>gD", function()
        gs.diffthis("~")
      end, "Git Diff This ~")
      map("n", "<leader>gt", gs.toggle_deleted, "Git Toggle Deleted")

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Git Select Hunk")
    end,
  },
}
