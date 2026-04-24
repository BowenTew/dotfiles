# Dotfiles

使用 [chezmoi](https://www.chezmoi.io/) 管理的 dotfiles。

## 快速开始

### 安装 chezmoi

```bash
# macOS
brew install chezmoi

# Linux
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### 克隆并应用

```bash
chezmoi init --apply <your-repo-url>
```

### 新机器初始化

```bash
# 1. 安装 chezmoi
# 2. 从本仓库初始化
chezmoi init --apply https://github.com/<user>/<repo>.git

# 或 SSH 方式
chezmoi init --apply git@github.com:<user>/<repo>.git
```

## 日常命令

| 命令 | 说明 |
|------|------|
| `chezmoi edit <file>` | 在源目录编辑受管文件 |
| `chezmoi apply` | 将源目录更改应用到目标位置 |
| `chezmoi diff` | 查看待应用的更改 |
| `chezmoi status` | 列出受管文件及其状态 |
| `chezmoi add <file>` | 将新文件纳入管理 |
| `chezmoi re-add <file>` | 将目标文件的更改回写到源目录 |
| `chezmoi cd` | 跳转到源目录 |
| `chezmoi doctor` | 检查配置问题 |

## 常见场景

### 编辑配置并应用

```bash
# 在源目录编辑（打开 $EDITOR）
chezmoi edit ~/.config/nvim/init.lua

# 应用到目标位置
chezmoi apply

# 或编辑并一步应用
chezmoi edit --apply ~/.config/nvim/init.lua
```

### 目标文件被修改（如 lazy-lock.json 更新）

```bash
# 将更改回写到源目录
chezmoi re-add ~/.config/nvim/lazy-lock.json

# 或批量回写所有更改的文件
chezmoi re-add
```

### 添加新的 dotfile

```bash
chezmoi add ~/.config/some-app/config.toml
chezmoi edit ~/.config/some-app/config.toml
chezmoi apply
```

### 预览即将应用的更改

```bash
chezmoi diff
chezmoi apply --dry-run
```

### 从上游更新

```bash
chezmoi update
# 等价于：
#   chezmoi git pull
#   chezmoi apply
```

## 目录结构

```
~/.local/share/chezmoi/
├── README.md              # 本文件
├── README.zh.md           # 中文文档
├── dot_config/            # ~/.config/
│   └── nvim/              # Neovim 配置 (AeonVim)
│       ├── init.lua
│       ├── lua/
│       └── lazy-lock.json
└── ...                    # 其他 dotfiles
```

命名规则：

| 前缀 | 作用 |
|------|------|
| `dot_` | 映射为 `.`（如 `dot_config` → `~/.config`） |
| `private_` | 设置 0600 权限 |
| `executable_` | 设置可执行权限 |
| `symlink_` | 创建符号链接而非复制 |
| `literal_` | 禁用属性前缀解析 |

## 模板

`.tmpl` 后缀的文件会被当作 Go 模板处理：

```bash
# 创建模板
chezmoi add --autotemplate ~/.gitconfig

# 查看可用模板变量
chezmoi data

# 测试模板渲染
chezmoi execute-template
```

模板示例（`dot_gitconfig.tmpl`）：
```
[user]
    name = {{ .name }}
    email = {{ .email }}
```

## 按机器区分配置

使用 `chezmoi.toml` 存储机器专属设置：

```bash
chezmoi init
# 编辑 ~/.config/chezmoi/chezmoi.toml
chezmoi data  # 验证变量
```

或在源目录放置 `.chezmoi.toml.tmpl` 实现模板化配置。

## 密钥管理

### 1Password
```bash
chezmoi edit --1password <file>
```

### Bitwarden
```bash
chezmoi edit --bitwarden <file>
```

### age 加密
```bash
# 加密文件
chezmoi encrypt <file>

# 应用时自动解密
chezmoi apply
```

## Git 工作流

```bash
chezmoi cd                    # 进入源目录
git add .
git commit -m "update nvim config"
git push
```

或在任意位置：
```bash
chezmoi git add .
chezmoi git commit -- -m "update"
chezmoi git push
```

## 参考

- [chezmoi 文档](https://www.chezmoi.io/)
- [使用指南](https://www.chezmoi.io/user-guide/daily-operations/)
- [模板语法](https://www.chezmoi.io/user-guide/templating/)
