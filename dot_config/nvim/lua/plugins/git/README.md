# Git 插件配置

本目录包含所有 Git 相关插件的配置，提供完整的 Git 工作流支持。

## 插件列表

| 插件 | 用途 | 仓库 |
|------|------|------|
| gitsigns | 行内 Git 标记（增删改） | lewis6991/gitsigns.nvim |
| diffview | 强大的 Diff 查看器和冲突解决 | sindrets/diffview.nvim |
| lazygit | 集成 lazygit TUI | kdheepak/lazygit.nvim |
| git-conflict | 冲突解决辅助 | akinsho/git-conflict.nvim |

---

## Gitsigns - 行内 Git 标记

显示文件修改、添加、删除的行内标记，支持 stage/reset 等操作。

### 快捷键

#### 导航
| 快捷键 | 功能 |
|--------|------|
| `]g` | 下一个 Git Hunk |
| `[g` | 上一个 Git Hunk |

#### 操作
| 快捷键 | 功能 |
|--------|------|
| `<leader>gs` | Stage Hunk |
| `<leader>gr` | Reset Hunk |
| `<leader>gS` | Stage 整个 Buffer |
| `<leader>gR` | Reset 整个 Buffer |
| `<leader>gu` | Undo Stage Hunk |
| `<leader>gp` | Preview Hunk |
| `<leader>gb` | Blame 当前行 |
| `<leader>gB` | 切换行内 Blame |
| `<leader>gd` | Diff 当前文件 |
| `<leader>gD` | Diff 当前文件（与 HEAD~） |
| `<leader>gt` | 切换显示已删除内容 |

#### 文本对象
| 快捷键 | 功能 |
|--------|------|
| `ih` (operator/visual) | 选择 Hunk |

---

## Diffview - Diff 查看器

查看工作区与 index 的差异、分支对比、文件历史等。

### 全局快捷键

| 快捷键 | 功能 |
|--------|------|
| `<leader>gdo` | 打开 Diffview |
| `<leader>gdc` | 关闭 Diffview |
| `<leader>gdh` | 查看整个仓库的提交历史 |
| `<leader>gdH` | 查看当前文件的提交历史 |

### Diff 视图内快捷键

| 快捷键 | 功能 |
|--------|------|
| `<tab>` / `<s-tab>` | 切换到下一个/上一个文件 |
| `gf` | 跳转到源文件 |
| `<C-w><C-f>` | 分屏打开源文件 |
| `<leader>e` | 聚焦文件面板 |
| `<leader>b` | 切换文件面板显示/隐藏 |
| `g<C-x>` | 循环切换布局 |

### 冲突解决（Diff 视图内）

| 快捷键 | 功能 |
|--------|------|
| `[x` / `]x` | 上一个/下一个冲突 |
| `<leader>co` | 选择 ours（当前分支） |
| `<leader>ct` | 选择 theirs（目标分支） |
| `<leader>cb` | 选择 base（共同祖先） |
| `<leader>ca` | 选择 all（保留全部） |
| `dx` | 选择 none（删除冲突块） |

### 三路合并（diff3）

| 快捷键 | 功能 |
|--------|------|
| `2do` | 获取 ours 的修改 |
| `3do` | 获取 theirs 的修改 |

### 文件面板快捷键

| 快捷键 | 功能 |
|--------|------|
| `j/k` | 上下移动 |
| `o` / 双击 | 打开文件 diff |
| `-` | 暂存/取消暂存当前文件 |
| `S` | 暂存全部（git add -A） |
| `U` | 取消暂存全部 |
| `X` | 还原文件 |
| `R` | 刷新文件列表 |
| `L` | 查看提交日志 |
| `i` | 切换列表/树视图 |
| `f` | 切换目录折叠 |

---

## Lazygit - 终端 Git 客户端

在浮动窗口中打开 lazygit TUI。

### 快捷键

| 快捷键 | 功能 |
|--------|------|
| `<leader>gg` | 打开 Lazygit（项目根目录） |
| `<leader>gG` | 打开 Lazygit（当前文件目录） |
| `<leader>gf` | 打开 Filter 视图 |
| `<leader>gF` | 打开 Filter 视图（当前文件） |

---

## Git Conflict - 冲突解决辅助

高亮冲突标记，提供快速选择命令。

### 快捷键

| 快捷键 | 功能 |
|--------|------|
| `<leader>gco` | 选择 Ours |
| `<leader>gct` | 选择 Theirs |
| `<leader>gcb` | 选择 Both |
| `<leader>gc0` | 选择 None |
| `<leader>gcn` | 下一个冲突 |
| `<leader>gcp` | 上一个冲突 |
| `<leader>gcl` | 列出所有冲突（Quickfix） |

---

## 功能开关

在 `config/global.lua` 中控制：

```lua
features = {
  git = {
    gitsigns = { enabled = true },
    diffview = { enabled = true },
    lazygit = { enabled = true },
  },
}
```
