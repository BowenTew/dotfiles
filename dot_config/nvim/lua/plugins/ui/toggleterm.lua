return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermExec" },
  specs = {
    {
      "nvim-neo-tree/neo-tree.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.commands then opts.commands = {} end
        if not opts.window then opts.window = {} end
        if not opts.window.mappings then opts.window.mappings = {} end

        local function toggleterm_in_direction(state, direction)
          local node = state.tree:get_node()
          local path = node.type == "file" and node:get_parent_id() or node:get_id()
          require("toggleterm.terminal").Terminal:new({ dir = path, direction = direction }):toggle()
        end

        local prefix = "t"
        ---@diagnostic disable-next-line: assign-type-mismatch
        opts.window.mappings[prefix] =
        { "show_help", nowait = false, config = { title = "New Terminal", prefix_key = prefix } }
        for suffix, direction in pairs({ f = "float", h = "horizontal", v = "vertical" }) do
          local command = "toggleterm_" .. direction
          opts.commands[command] = function(state) toggleterm_in_direction(state, direction) end
          opts.window.mappings[prefix .. suffix] = command
        end
      end,
    },
  },
  keys = function()
    --- Open a toggleterm in the given direction, safely switching away from
    --- special buffers (neo-tree, help, quickfix, etc.) before splitting.
    --- Float terminals skip this check as they don't depend on window layout.
    ---@param direction "horizontal"|"vertical"|"float"
    local function open_term(direction)
      return function()
        if direction ~= "float" and vim.bo.buftype ~= "" then
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "" then
              vim.api.nvim_set_current_win(win)
              break
            end
          end
        end
        vim.cmd("ToggleTerm direction=" .. direction)
      end
    end

    --- Return the next unused terminal ID.
    local function next_term_id()
      local terms = require("toggleterm.terminal").get_all()
      local max_id = 0
      for _, t in ipairs(terms) do
        if t.id > max_id then max_id = t.id end
      end
      return max_id + 1
    end

    return {
      { "<leader>tt", '<Cmd>execute v:count . "ToggleTerm"<CR>',              desc = "Toggle terminal" },
      { "<leader>th", open_term("horizontal"),                                desc = "Terminal Horizontal" },
      { "<leader>tv", open_term("vertical"),                                  desc = "Terminal Vertical" },
      { "<leader>tf", open_term("float"),                                     desc = "Terminal Float" },
      { "<leader>tn", function() vim.cmd(next_term_id() .. "ToggleTerm") end, desc = "New terminal" },
      { "<Esc><Esc>", '<C-\\><C-n>',                               mode = "t", desc = "Exit terminal mode" },
    }
  end,
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return math.floor(vim.o.columns * 0.4)
      end
      return 20
    end,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    persist_size = true,
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      width = math.floor(vim.o.columns * 0.7),
      height = math.floor(vim.o.lines * 0.8),
      winblend = 4,
    },
    on_create = function()
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.signcolumn = "no"
    end,
    on_open = function()
      vim.cmd("startinsert!")
    end,
  },
}
