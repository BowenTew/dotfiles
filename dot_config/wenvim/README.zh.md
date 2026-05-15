# AeonVim - Neovim 配置

模块化 Neovim 配置框架，支持版本锁定和回滚机制。

## 🎯 设计理念

| 来源 | 借鉴的优点 |
|------|-----------|
| **AstroNvim** | 美观的 UI 设计、模块化结构 |
| **LazyVim** | 合理的默认配置、灵活的扩展机制 |
| **LunarVim** | 独立隔离的运行环境、版本锁定 |
| **NormalNvim** | 稳定性优先、热重载、回滚机制 |
| **NvChad** | 极速启动、丰富的主题 |
| **Ecovim** | 前端开发优化、AI 集成 |

## 📁 目录结构

```
~/.config/nvim/
├── init.lua                    # 入口文件
├── lua/
│   ├── config/
│   │   ├── global.lua          # 全局配置对象
│   │   ├── options.lua         # 基础选项
│   │   ├── keymaps.lua         # 键位映射
│   │   ├── autocmds.lua        # 自动命令
│   │   ├── lazy.lua            # 插件管理器
│   │   └── lsp/                # LSP 服务器配置
│   │       ├── init.lua        # 服务器列表
│   │       ├── clangd.lua      # C/C++
│   │       ├── go.lua          # Go
│   │       ├── lua_ls.lua      # Lua
│   │       ├── rust.lua        # Rust
│   │       ├── typescript.lua  # TypeScript
│   │       └── vue.lua         # Vue
│   ├── plugins/                # 插件配置
│   │   ├── init.lua            # 插件入口
│   │   ├── base/               # 基础依赖
│   │   ├── editor/             # 编辑器增强
│   │   ├── finder/             # 查找/搜索
│   │   ├── git/                # Git 相关
│   │   ├── lsp/                # LSP/DAP/格式化
│   │   ├── ui/                 # UI 组件
│   │   └── languages/          # 语言特定插件
│   ├── utils/                  # 工具函数
│   │   ├── icons.lua           # 图标定义
│   │   ├── globals.lua         # 全局函数
│   │   ├── functions.lua       # 工具函数
│   │   └── distro.lua          # (已移除，直接用 git)
│   ├── internal/               # 内部模块
│   │   └── cursorword.lua      # 光标单词高亮
│   └── lazy_snapshot.lua       # (已弃用，由 lazy-lock.json 替代)
└── after/queries/              # Treesitter 查询覆盖
```

## ⚙️ 全局配置对象

通过修改 `AeonVim` 对象来自定义配置：

```lua
-- lua/config/global.lua
_G.AeonVim = {
  version = "0.1.0",
  colorscheme = "base46-vscode_dark",

  -- 图标配置
  icons = require("utils.icons"),

  -- 键位配置
  keys = {
    leader = " ",
    localleader = ",",
  },
}
```

所有插件默认启用，如需禁用某个插件，可在对应插件文件中设置 `enabled = false`。

## ⌨️ 核心快捷键

### 基础操作
| 快捷键 | 功能 |
|--------|------|
| `<Space>` | Leader 键 |
| `<C-s>` | 保存文件 |
| `<C-q>` | 退出 |
| `<Esc>` / `<leader>h` | 取消搜索高亮 |
| `jk` / `jj` | 退出插入模式 |
| `H` / `L` | 跳到行首 / 行尾 |
| `<A-j>` / `<A-k>` | 移动行（支持普通/插入/可视模式） |
| `<leader>y` / `<leader>Y` | 复制到系统剪贴板 |
| `<leader>p` / `<leader>P` | 从 yank 寄存器粘贴 |
| `<leader>d` / `<leader>c` | 黑洞删除 / 修改 |

### 窗口导航
| 快捷键 | 功能 |
|--------|------|
| `<C-h/j/k/l>` | 切换窗口（含终端模式） |
| `<C-方向键>` | 调整窗口大小 |
| `<leader>-` | 水平分割 |
| `<leader>\|` | 垂直分割 |
| `<leader>xs` | 关闭分屏 |
| `<leader>se` | 等分窗口 |

### 文件操作
| 快捷键 | 功能 |
|--------|------|
| `<leader>e` | 打开/关闭文件树 (Neo-tree) |
| `<leader>o` | 聚焦文件树 |
| `<leader>ge` | Git 状态文件树 |
| `<leader>be` | Buffer 文件树 |
| `<leader>ff` / `<leader><space>` | 查找文件 (Telescope) |
| `<leader>fF` | 查找文件（含隐藏文件） |
| `<leader>fg` | 查找 Git 文件 |
| `<leader>fr` | 最近文件 |
| `<leader>/` / `<leader>sg` | 全局搜索 (live_grep) |
| `<leader>sw` | 搜索当前单词 |
| `<leader>,` | 切换 Buffer |

### 缓冲区
| 快捷键 | 功能 |
|--------|------|
| `<leader>fb` | Buffer 列表 |
| `<leader>bd` | 删除当前 Buffer（Telescope 内 `<C-d>` / `dd`） |

### LSP
| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gr` | 查看引用 |
| `gI` | 跳转到实现 |
| `K` | 悬停文档 |
| `<leader>ca` | 代码操作 |
| `<leader>cr` | 重命名 |
| `<leader>cf` | 格式化 |
| `<leader>ss` | 文档符号 |
| `<leader>sS` | 工作区符号 |

### 诊断
| 快捷键 | 功能 |
|--------|------|
| `[d` / `]d` | 诊断导航 |
| `[e` / `]e` | 错误导航 |
| `[w` / `]w` | 警告导航 |
| `<leader>sd` | 所有诊断 (Telescope) |
| `<leader>sD` | 当前 Buffer 诊断 |

### 快速跳转 (flash.nvim)
| 快捷键 | 功能 |
|--------|------|
| `s` | Flash 跳转 |
| `S` | Treesitter 跳转 |
| `r` (Operator) | Remote Flash |
| `R` (Operator/Visual) | Treesitter Search |
| `<C-s>` (Cmd) | Toggle Flash Search |

### 会话管理 (persistence.nvim)
| 快捷键 | 功能 |
|--------|------|
| `<leader>qs` | 恢复当前目录会话 |
| `<leader>ql` | 恢复上一次会话 |
| `<leader>qd` | 不保存当前会话 |

### 插件版本
| 快捷键 | 功能 |
|--------|------|
| `<leader>pS` | 从 lockfile 恢复插件版本 |

## 🚀 快速开始

### 安装

```bash
# 备份现有配置
mv ~/.config/nvim ~/.config/nvim.bak

# 克隆配置
git clone <your-repo> ~/.config/nvim

# 启动 Neovim
nvim
```

### 首次启动

1. lazy.nvim 会自动安装
2. 所有插件会自动下载
3. Treesitter 语法会自动安装
4. LSP 服务器可通过 `:Mason` 安装

## 🔧 自定义配置

### 添加新插件

在 `lua/plugins/` 目录下创建新的配置文件：

```lua
-- lua/plugins/myplugin.lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy",
    config = function()
      require("plugin-name").setup({
        -- 配置
      })
    end,
  },
}
```

### 修改键位

编辑 `lua/config/keymaps.lua`：

```lua
vim.keymap.set("n", "<leader>xx", "<cmd>MyCommand<CR>", { desc = "My description" })
```

### 修改选项

编辑 `lua/config/options.lua`：

```lua
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
```

## 📦 预配置插件

### UI
- [x] **base46** / tokyonight.nvim / catppuccin / onedark / yorumi — 配色方案
- [x] alpha-nvim — 启动页
- [x] noice.nvim — 通知/命令行/消息 UI 美化（替代 nvim-notify）
- [x] noice.nvim — 命令行/消息 UI 美化
- [x] nvim-web-devicons — 文件图标
- [x] neo-tree.nvim — 文件树浏览器
- [x] bufferline.nvim — Buffer 标签栏
- [x] lualine.nvim — 状态栏
- [x] which-key.nvim — 键位提示
- [x] toggleterm.nvim — 浮动终端

### 编辑器
- [x] nvim-treesitter — 语法高亮/折叠/文本对象
- [x] blink.cmp — 异步补全引擎
- [x] LuaSnip — 代码片段
- [x] nvim-autopairs — 自动括号配对
- [x] Comment.nvim — 快速注释
- [x] nvim-surround — 环绕字符操作（v4+ 简化配置）
- [x] indent-blankline.nvim — 缩进线
- [x] flash.nvim — 快速跳转
- [x] multicursors.nvim — 多光标编辑（使用 nvimtools/hydra.nvim）
- [x] hlslens.nvim — 搜索高亮增强
- [x] rainbow-delimiters.nvim — 彩虹括号
- [x] todo-comments.nvim — TODO 高亮

### 查找
- [x] telescope.nvim — 模糊查找器
- [x] telescope-fzf-native.nvim — fzf 排序引擎

### LSP / 格式化 / Lint
- [x] nvim-lspconfig — LSP 客户端配置
- [x] mason.nvim — LSP/DAP/工具安装器
- [x] mason-lspconfig.nvim — Mason 与 lspconfig 桥接
- [x] mason-tool-installer.nvim — 工具自动安装
- [x] conform.nvim — 代码格式化
- [x] nvim-lint — 代码检查

### Git
- [x] gitsigns.nvim — Git 标记/ blame
- [x] diffview.nvim — 差异查看
- [x] lazygit.nvim — Lazygit 集成
- [x] git-conflict.nvim — 冲突解决

### 终端
- [x] toggleterm.nvim — 终端管理

### 会话管理
- [x] persistence.nvim — 自动会话保存/恢复

## 🌐 预配置 LSP 服务器

| 语言 | 服务器 | 配置文件 |
|------|--------|---------|
| C/C++ | `clangd` | `lua/config/lsp/clangd.lua` |
| Go | `gopls` | `lua/config/lsp/go.lua` |
| Lua | `lua_ls` | `lua/config/lsp/lua_ls.lua` |
| Rust | `rust_analyzer` | `lua/config/lsp/rust.lua` |
| TypeScript | `ts_ls` | `lua/config/lsp/typescript.lua` |
| Vue | `vue_ls` | `lua/config/lsp/vue.lua` |

添加新服务器：在 `lua/config/lsp/` 下新建配置文件，并在 `lua/config/lsp/init.lua` 中注册。

## 🎨 配色方案

内置主题：
- `base46-vscode_dark` (默认)
- `tokyonight-night` / `tokyonight-storm` / `tokyonight-day`
- `catppuccin`
- `onedark`
- `yorumi`

切换主题：
```vim
:colorscheme catppuccin
```
或运行 `:Telescope colorscheme` (`<leader>uC`) 预览切换。

## 🔄 版本管理

AeonVim 使用 lazy.nvim 原生的 **lockfile** 机制实现插件版本锁定。

### 工作原理

lazy.nvim 会自动在配置目录维护 `lazy-lock.json` 文件。将它提交到 git，即可在所有机器上保持一致的插件版本。

| 场景 | 操作 |
|------|------|
| 新机器 / 全新克隆 | 按 `lazy-lock.json` 中的版本精确安装插件 |
| 更新插件 | 运行 `:Lazy update`，然后 `git commit lazy-lock.json` |
| 同步团队版本 | `git pull` 后运行 `:Lazy restore` 同步到提交版本 |
| 检查可用更新 | `:Lazy check` 只查看不安装 |

### 管理命令

| 命令 | 说明 |
|------|------|
| `:Lazy update` | 更新插件到最新版本 |
| `:Lazy restore` | 恢复到 `lazy-lock.json` 记录的版本 |
| `:Lazy sync` | 安装缺失 + 移除未用 + 恢复版本 |

## 📚 参考

- [AstroNvim](https://github.com/AstroNvim/AstroNvim)
- [LazyVim](https://github.com/LazyVim/LazyVim)
- [LunarVim](https://github.com/LunarVim/LunarVim)
- [NormalNvim](https://github.com/NormalNvim/NormalNvim)
- [NvChad](https://github.com/NvChad/NvChad)
- [Ecovim](https://github.com/ecosse3/nvim)

## 📝 License

MIT
