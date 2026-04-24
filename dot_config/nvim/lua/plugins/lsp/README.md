# LSP 插件模块

本目录管理 Neovim 的语言服务协议（LSP）相关插件，提供代码智能补全、诊断、格式化、代码检查等核心开发功能。

## 架构总览

```
lsp/
├── init.lua              # 模块入口，按顺序加载下方所有插件
├── mason.lua             # 工具安装器
├── mason-lspconfig.lua   # Mason ↔ LSPConfig 桥接 + LSP 快捷键
├── lspconfig.lua         # LSP 核心配置（诊断、inlay hints、折叠）
├── luasnip.lua           # 代码片段引擎
├── conform.lua           # 代码格式化
├── lint.lua              # 代码检查（linting）
└── servers/              # 各语言 LSP 服务器的独立配置
    ├── init.lua           # 服务器注册表
    ├── go.lua             # gopls 配置
    ├── lua_ls.lua         # lua_ls 配置
    ├── rust.lua           # rust_analyzer 配置
    └── typescript.lua     # ts_ls 配置
```

## 数据流

```
打开文件 → mason-lspconfig 确保服务器已安装
        → lspconfig 根据 filetype 启动对应 LSP 服务器
        → LspAttach 事件触发 → 绑定快捷键
        → 编辑代码时：LSP 提供补全/诊断，lint 提供额外检查
        → 保存文件时：conform 自动格式化
```

---

## 插件介绍

### 1. mason.nvim

- **文件：** `mason.lua`
- **插件：** [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim)
- **作用：** 外部工具包管理器，统一下载/安装/更新 LSP 服务器、DAP 调试器、Linter、Formatter 的二进制文件。
- **使用：** 执行 `:Mason` 打开管理界面，可查看/安装/卸载工具。
- **说明：** 只负责安装，不负责配置。具体的 LSP 配置由 lspconfig 和 mason-lspconfig 完成。

### 2. mason-lspconfig.nvim

- **文件：** `mason-lspconfig.lua`
- **插件：** [mason-org/mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim)
- **作用：** Mason 和 lspconfig 之间的桥梁。自动安装声明的 LSP 服务器，并在 LSP 附加到 buffer 时统一绑定快捷键。

#### 自动安装的服务器

| 服务器 | 语言 |
|---|---|
| `bashls` | Bash |
| `clangd` | C / C++ |
| `cssls` | CSS |
| `dockerls` | Dockerfile |
| `eslint` | JS/TS Linting |
| `gopls` | Go |
| `html` | HTML |
| `jsonls` | JSON |
| `lua_ls` | Lua |
| `nil_ls` | Nix |
| `pyright` | Python |
| `rust_analyzer` | Rust |
| `svelte` | Svelte |
| `taplo` | TOML |
| `ts_ls` | TypeScript / JavaScript |
| `volar` | Vue |
| `yamlls` | YAML |

#### LSP 快捷键（仅在 LSP 激活的 buffer 中生效）

**导航跳转**

| 按键 | 功能 |
|---|---|
| `gd` | 跳转到定义 |
| `gr` | 查看所有引用 |
| `gI` | 跳转到接口实现 |
| `gy` | 跳转到类型定义 |
| `gD` | 跳转到声明 |

**文档与签名**

| 按键 | 功能 |
|---|---|
| `K` | 悬浮文档（hover） |
| `gK` | 函数签名帮助（normal 模式） |
| `<C-k>` | 函数签名帮助（insert 模式，写参数时用） |

**代码操作**

| 按键 | 功能 |
|---|---|
| `<leader>ca` | 代码动作（快速修复、重构等） |
| `<leader>cr` | 重命名符号（全项目生效） |
| `<leader>cf` | 格式化当前文件 |

**诊断导航**

| 按键 | 功能 |
|---|---|
| `<leader>cd` | 弹出当前行诊断详情 |
| `]d` / `[d` | 下一个 / 上一个诊断 |
| `]e` / `[e` | 下一个 / 上一个错误（仅 ERROR 级别） |

**LSP 管理**

| 按键 | 功能 |
|---|---|
| `<leader>li` | 显示 LSP 信息（`:LspInfo`） |
| `<leader>lr` | 重启 LSP（`:LspRestart`） |

### 3. nvim-lspconfig

- **文件：** `lspconfig.lua`
- **插件：** [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- **作用：** LSP 核心配置。负责：
  - **诊断显示** — 行内虚拟文本（`●` 前缀）、侧边栏图标、浮窗诊断详情
  - **Inlay Hints** — 在代码中内联显示类型推断、参数名等提示（默认启用）
  - **代码折叠** — 基于 LSP 的智能折叠（按函数/类/块折叠）
  - **服务器配置** — 从 `servers/` 目录加载各语言的独立配置

### 4. LuaSnip

- **文件：** `luasnip.lua`
- **插件：** [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) + [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- **作用：** 代码片段引擎。支持所有语言（不只 Lua），根据当前 filetype 按需加载对应片段。
- **使用：** 在补全菜单中选择带 snippet 标记的条目即可展开，按 `<Tab>` 跳转到下一个占位符。
- **片段来源：** `friendly-snippets` 提供了几十种语言的预置片段（如 Go 的 `iferr`、JS 的 `clg` → `console.log()` 等）。

### 5. conform.nvim

- **文件：** `conform.lua`
- **插件：** [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)
- **作用：** 代码格式化引擎。按文件类型配置不同的 formatter，支持保存时自动格式化。
- **使用：** 执行 `:ConformInfo` 查看当前文件使用的 formatter。

#### Formatter 配置

| 文件类型 | Formatter |
|---|---|
| Lua | `stylua` |
| Python | `isort` + `black` |
| JavaScript / TypeScript | `prettier` |
| JSON / YAML / Markdown | `prettier` |
| 其他所有文件 | `trim_whitespace`（清除行尾空格） |

- **保存时格式化：** 默认启用，保存时自动格式化（超时 500ms）。
- **LSP 回退：** 当没有配置 formatter 时，自动回退到 LSP 自带的格式化功能。

### 6. nvim-lint

- **文件：** `lint.lua`
- **插件：** [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)
- **作用：** 异步代码检查引擎。与 LSP 诊断互补，提供额外的 linting 规则。
- **触发时机：** 保存文件后、读取文件后、离开 insert 模式后自动运行。

#### Linter 配置

| 文件类型 | Linter |
|---|---|
| Lua | `luacheck` |
| Python | `flake8` |
| JavaScript / TypeScript | `eslint` |

---

## servers/ 目录

各语言 LSP 服务器的独立配置文件。每个文件返回一个配置表，由 `lspconfig.lua` 统一注册。

| 文件 | 服务器 | 主要配置 |
|---|---|---|
| `go.lua` | `gopls` | gofumpt、staticcheck、分析器（unused/shadow/nilness）、codelens、inlay hints |
| `lua_ls.lua` | `lua_ls` | `vim` 全局变量识别、hint 启用 |
| `rust.lua` | `rust_analyzer` | Rust 语言服务器配置 |
| `typescript.lua` | `ts_ls` | TypeScript/JavaScript 语言服务器配置 |

### 添加新语言

1. 在 `servers/` 下创建配置文件（如 `python.lua`）
2. 在 `servers/init.lua` 中注册：`pyright = require("plugins.lsp.servers.python")`
3. 确保 `mason-lspconfig.lua` 的 `ensure_installed` 中包含对应服务器名

没有自定义配置文件的服务器（如 `bashls`、`html`）会使用 lspconfig 的默认配置自动启动。
