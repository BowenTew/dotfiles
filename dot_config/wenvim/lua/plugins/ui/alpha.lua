-- ============================================================================
-- 启动页插件配置 (lazy spec)
-- ============================================================================

return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      local header = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }

      dashboard.section.header.val = header
      dashboard.section.header.opts.hl = "AlphaHeader"

      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find File", "<cmd>Telescope find_files<CR>"),
        dashboard.button("n", " " .. " New File", "<cmd>ene <BAR> startinsert<CR>"),
        dashboard.button("r", " " .. " Recent Files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("g", " " .. " Find Text", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("p", " " .. " Projects", "<cmd>Telescope projects<CR>"),
        dashboard.button("s", " " .. " Restore Session", [[<cmd>lua require("persistence").load()<CR>]]),
        dashboard.button("c", " " .. " Config", "<cmd>e ~/.config/nvim/init.lua<CR>"),
        dashboard.button("l", " " .. " Lazy", "<cmd>Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", "<cmd>qa<CR>"),
      }

      local function footer()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
      end

      dashboard.section.footer.val = footer()
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }
      dashboard.config.opts.noautocmd = true

      vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#7aa2f7", bold = true })
      vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#565f89" })

      alpha.setup(dashboard.config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          dashboard.section.footer.val = footer()
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
