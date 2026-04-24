-- ==========================================================================
-- Telescope - 模糊查找器
-- ==========================================================================
return { 
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    keys = {
      -- 文件查找
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fF", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files (include hidden)" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      
      -- 内容搜索
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Grep Word" },
      
      -- Buffer 切换
      { "<leader>,", "<cmd>Telescope buffers sort_mru=true<cr>", desc = "Switch Buffer" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      
      -- LSP 相关
      { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "<leader>sS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
      
      -- Git 相关
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git Status" },
      
      -- 其他
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>uC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
    },
    opts = function()
      local actions = require("telescope.actions")
      
      local find_command = function()
        if vim.fn.executable("rg") == 1 then
          return { "rg", "--files", "--color", "never", "-g", "!.git" }
        elseif vim.fn.executable("fd") == 1 then
          return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
        elseif vim.fn.executable("fdfind") == 1 then
          return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
        end
      end
      
      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "smart" },
          file_ignore_patterns = { ".git/", "node_modules/", ".cache/" },
          mappings = {
            i = {
              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,
              ["<CR>"] = actions.select_default,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = find_command(),
            hidden = true,
          },
          live_grep = {
            only_sort_text = true,
          },
          buffers = {
            sort_mru = true,
            sort_lastused = true,
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      
      -- 加载扩展
      pcall(require("telescope").load_extension, "fzf")
    end,
  }

