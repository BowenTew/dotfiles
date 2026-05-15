-- ============================================================================
-- 插件管理器配置 (lazy.nvim)
-- lazy.nvim 原生 lockfile 机制实现版本锁定
-- ============================================================================

--- 下载 lazy.nvim（首次启动）
local function git_clone_lazy(lazy_dir)
  local output = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazy_dir,
  })
  if vim.api.nvim_get_vvar("shell_error") ~= 0 then
    vim.api.nvim_echo(
      {{"Error cloning lazy.nvim repository...\n\n" .. output}},
      true, {err = true}
    )
  end
end

--- 首次启动后自动加载关键插件
local function after_installing_plugins_load(plugins)
  local oldcmdheight = vim.opt.cmdheight:get()
  vim.opt.cmdheight = 1
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyInstall",
    once = true,
    callback = function()
      vim.cmd.bw()
      vim.opt.cmdheight = oldcmdheight
      vim.tbl_map(function(module) pcall(require, module) end, plugins)
    end,
    desc = "Load Mason and Treesitter after Lazy installs plugins",
  })
end

--- 设置 lazy.nvim
local function setup_lazy(lazy_dir)
  vim.opt.rtp:prepend(lazy_dir)
  require("lazy").setup({
    spec = require("plugins"),
    defaults = {
      lazy = true,
    },
    install = {
      colorscheme = { "tokyonight-night", "habamax" },
      missing = true,
    },
    ui = {
      size = { width = 0.8, height = 0.8 },
      border = "rounded",
      title = " Plugin Manager ",
      title_pos = "center",
      pills = true,
      icons = {
        cmd = "⌘",
        config = "🛠",
        event = "📅",
        ft = "📂",
        init = "⚙",
        keys = "🗝",
        plugin = "🔌",
        runtime = "💻",
        source = "📄",
        start = "🚀",
        task = "📌",
        lazy = "💤 ",
      },
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
    checker = {
      enabled = false,
      notify = false,
      frequency = 86400,
    },
    change_detection = {
      enabled = true,
      notify = false,
    },
    -- lockfile 放在配置目录，可随 git 提交实现跨机器版本锁定
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  })
end

-- 主流程
local lazy_dir = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local is_first_startup = not vim.uv.fs_stat(lazy_dir)

if is_first_startup then
  git_clone_lazy(lazy_dir)
  after_installing_plugins_load({ "nvim-treesitter", "mason" })
  vim.notify("Please wait while plugins are installed...")
end

setup_lazy(lazy_dir)

-- 快捷键
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy" })
