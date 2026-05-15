# UI 插件模块

本目录管理 Neovim 的用户界面相关插件，包括文件浏览器、Buffer 标签栏、终端、通知、命令面板、主题配色等。

## 架构总览

```
ui/
├── init.lua          # 模块入口，按顺序加载下方所有插件
├── neo-tree.lua      # 文件树浏览器
├── bufferline.lua    # 顶部 Buffer 标签栏
├── which-key.lua     # 快捷键提示面板
├── alpha.lua         # 启动页 / Dashboard
├── notify.lua        # 通知弹窗
├── noice.lua         # 命令行 / 消息 UI 增强
├── toggleterm.lua    # 内置终端管理器
├── icon.lua          # 文件类型图标
└── themes/           # 主题配色
    ├── init.lua       # 主题入口
    ├── tokyonight.lua # Tokyo Night（默认主题）
    ├── catppuccin.lua # Catppuccin
    └── onedark.lua    # One Dark
```

---

## 插件介绍

### 1. Neo-tree

- **文件：** `neo-tree.lua`
- **插件：** [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- **作用：** 侧边栏文件树浏览器，支持文件操作、Git 状态显示、LSP 诊断标记、模糊搜索。

#### 快捷键

**全局**

| 按键 | 功能 |
|---|---|
| `<leader>e` | 切换文件树开/关 |
| `<leader>o` | 聚焦文件树 |
| `<leader>ge` | 打开 Git 状态视图 |
| `<leader>be` | 打开 Buffers 视图 |

**文件树内**

| 按键 | 功能 |
|---|---|
| `<CR>` / 双击 | 打开文件 |
| `s` | 垂直分屏打开 |
| `S` | 水平分屏打开 |
| `t` | 新标签页打开 |
| `P` | 浮窗预览 |
| `a` | 新建文件 |
| `A` | 新建目录 |
| `d` | 删除 |
| `r` | 重命名 |
| `y` / `x` / `p` | 复制 / 剪切 / 粘贴 |
| `c` / `m` | 复制到 / 移动到 |
| `C` | 收起节点 |
| `z` / `Z` | 收起全部 / 展开全部 |
| `H` | 显示/隐藏隐藏文件 |
| `/` | 模糊搜索文件 |
| `D` | 模糊搜索目录 |
| `[g` / `]g` | 上一个/下一个 Git 修改 |
| `R` | 刷新 |
| `q` | 关闭 |
| `?` | 帮助 |

**Git 状态视图内**

| 按键 | 功能 |
|---|---|
| `ga` | git add 文件 |
| `gu` | git unstage 文件 |
| `gr` | git revert 文件 |
| `gc` | git commit |
| `gp` | git push |
| `gg` | git commit 并 push |
| `A` | git add 全部 |

**排序（所有视图）**

| 按键 | 功能 |
|---|---|
| `o` | 排序菜单 |
| `oc` | 按创建时间 |
| `od` | 按诊断 |
| `og` | 按 Git 状态 |
| `om` | 按修改时间 |
| `on` | 按名称 |
| `os` | 按大小 |
| `ot` | 按类型 |

#### 特性
- 自动跟踪当前文件（`follow_current_file`）
- 隐藏 `node_modules` 和 dotfiles
- 最后一个窗口时自动关闭

---

### 2. Bufferline

- **文件：** `bufferline.lua`
- **插件：** [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- **作用：** 顶部 Buffer 标签栏，显示打开的文件标签、LSP 诊断计数、序号，支持鼠标操作。
- **启用条件：** 默认启用。

#### 快捷键

| 按键 | 功能 |
|---|---|
| `<Alt-1>` ~ `<Alt-9>` | 跳转到第 1~9 个 Buffer |
| `<leader>bp` | 按字母选择 Buffer（Pick） |
| `<leader>bP` | 固定/取消固定 Buffer（Pin） |
| `<leader>bb` | 将当前 Buffer 左移 |
| `<leader>bn` | 将当前 Buffer 右移 |
| `<leader>bl` | 关闭左侧所有 Buffer |
| `<leader>br` | 关闭右侧所有 Buffer |
| `<leader>bsd` | 按目录排序 |
| `<leader>bse` | 按扩展名排序 |
| `<leader>bsr` | 按相对路径排序 |

#### 特性
- 标签显示 LSP 诊断计数（Error / Warning）
- Hover 时显示关闭按钮
- 过滤 quickfix buffer
- 与 Neo-tree 侧边栏对齐偏移

---

### 3. Which-Key

- **文件：** `which-key.lua`
- **插件：** [folke/which-key.nvim](https://github.com/folke/which-key.nvim)
- **作用：** 按键提示面板。按下 `<leader>` 或其他前缀键后停顿，会弹出一个浮窗显示所有可用的后续按键及其功能描述。
- **使用：** 无需额外操作，按下前缀键等待即可。使用 `modern` 预设风格。

---

### 4. Alpha（启动页）

- **文件：** `alpha.lua`
- **插件：** [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim)
- **作用：** Neovim 启动时显示的 Dashboard 页面，包含 ASCII Art Logo 和常用操作快捷入口。

#### Dashboard 按钮

| 按键 | 功能 |
|---|---|
| `f` | 查找文件（Telescope） |
| `n` | 新建文件 |
| `r` | 最近打开的文件 |
| `g` | 全局文本搜索 |
| `p` | 打开项目 |
| `s` | 恢复上次会话 |
| `c` | 编辑 Neovim 配置 |
| `l` | 打开 Lazy 插件管理器 |
| `q` | 退出 |

- **底部信息栏：** 显示 Neovim 启动时间和加载的插件数量。

---

### 5. Notify（通知弹窗）

- **文件：** `notify.lua`
- **插件：** [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify)
- **作用：** 替换 Neovim 默认的 `vim.notify()`，用右上角的美观弹窗显示通知消息。
- **配置：** 渐隐动画（fade）、3 秒超时、最大占屏幕 75%。
- **使用：** 所有调用 `vim.notify()` 的插件（如 LSP、Git、格式化等）都会自动使用这个弹窗。

---

### 6. Noice（命令行 / 消息 UI 增强）

- **文件：** `noice.lua`
- **插件：** [folke/noice.nvim](https://github.com/folke/noice.nvim)
- **作用：** 重新设计 Neovim 的命令行、消息和通知 UI。将命令行移到屏幕中央弹窗（command palette 风格），长消息自动转到 split 窗口。
- **启用条件：** 默认启用。
- **当前配置：** 关闭了消息拦截（`messages.enabled = false`）、LSP hover 和 progress，主要只使用命令行弹窗功能。

---

### 7. ToggleTerm（终端管理器）

- **文件：** `toggleterm.lua`
- **插件：** [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- **作用：** 在 Neovim 内快速打开/切换终端，支持水平、垂直、浮窗三种布局。
- **启用条件：** 默认启用。

#### 快捷键

| 按键 | 功能 |
|---|---|
| `<F12>` | 切换终端开/关（normal 和 terminal 模式均可） |
| `<leader>th` | 打开水平终端（底部，高度 15 行） |
| `<leader>tv` | 打开垂直终端（右侧，宽度 40%） |
| `<leader>tf` | 打开浮窗终端（居中，宽 70% 高 80%） |

#### Neo-tree 集成

在文件树中可以直接在选中目录打开终端：

| 按键 | 功能 |
|---|---|
| `tf` | 在当前目录打开浮窗终端 |
| `th` | 在当前目录打开水平终端 |
| `tv` | 在当前目录打开垂直终端 |

---

### 8. Icon（文件图标）

- **文件：** `icon.lua`
- **插件：** [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- **作用：** 为文件类型提供 Nerd Font 图标。被 Neo-tree、Bufferline、Telescope 等多个插件依赖。
- **要求：** 终端需安装 [Nerd Font](https://www.nerdfonts.com/) 字体才能正确显示图标。

---

### 9. Themes（主题配色）

主题文件位于 `themes/` 子目录，通过 `themes/init.lua` 统一加载。

| 主题 | 文件 | 插件 | 状态 |
|---|---|---|---|
| **Tokyo Night** | `tokyonight.lua` | [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | **默认启用**（`lazy = false`），night 风格，支持透明背景 |
| Catppuccin | `catppuccin.lua` | [catppuccin/nvim](https://github.com/catppuccin/catppuccin) | 按需加载（`lazy = true`） |
| One Dark | `onedark.lua` | [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim) | 按需加载（`lazy = true`） |

- **切换主题：** 执行 `:colorscheme catppuccin` 或 `:colorscheme onedark` 即可切换。
- **透明背景：** 可在 tokyonight 主题配置中设置 `transparent = true` 启用。
