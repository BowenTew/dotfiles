# 编辑器增强插件

本目录包含所有编辑器功能增强相关的插件配置，每个插件独立成文件，便于单独维护和开关。

---

## 插件列表

### 1. treesitter.lua
**插件**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

提供语法树解析、语法高亮、代码折叠、智能缩进等功能。

**依赖插件**:
- `nvim-treesitter-textobjects` - 文本对象支持
- `nvim-ts-autotag` - 自动闭合 HTML/XML 标签
- `nvim-ts-context-commentstring` - 根据上下文智能注释

**快捷键**:

| 按键 | 模式 | 功能 |
|------|------|------|
| `<C-space>` | n/v | 开始/增加选择语法节点 |
| `<bs>` | n/v | 减少选择语法节点 |
| `aa` / `ia` | o | 参数外/内 |
| `af` / `if` | o | 函数外/内 |
| `ac` / `ic` | o | 类外/内 |
| `]f` / `[f` | n | 跳到下一个/上一个函数 |
| `]c` / `[c` | n | 跳到下一个/上一个类 |
| `]F` / `[F` | n | 跳到函数末尾 |
| `]C` / `[C` | n | 跳到类末尾 |

**命令**:
- `:TSInstall <lang>` - 安装指定语言的 parser
- `:TSUpdate` - 更新所有 parser

---

### 2. autopairs.lua
**插件**: [nvim-autopairs](https://github.com/windwp/nvim-autopairs)

自动补全括号、引号等配对符号。

**快捷键**:

| 按键 | 模式 | 功能 |
|------|------|------|
| `<M-e>` | i | 快速包裹（fast wrap） |

**说明**: 输入 `(`, `[`, `{`, `'`, `"` 时会自动补全对应的闭合符号。

---

### 3. comment.lua
**插件**: [Comment.nvim](https://github.com/numToStr/Comment.nvim)

快速注释/取消注释代码。

**快捷键**:

| 按键 | 模式 | 功能 |
|------|------|------|
| `gcc` | n | 切换当前行注释 |
| `gbc` | n | 切换当前行块注释 |
| `gc` | v | 切换选中区域行注释 |
| `gb` | v | 切换选中区域块注释 |
| `gc` | n + motion | 切换 motion 范围内的注释（如 `gcip` 注释当前段落） |

**说明**: 支持 Treesitter 上下文感知注释（如 Vue 文件中 `//` 和 `<!-- -->` 自动切换）。

---

### 4. surround.lua
**插件**: [nvim-surround](https://github.com/kylechui/nvim-surround)

快速添加、删除、修改包围字符（括号、引号、标签等）。

**快捷键**:

| 按键 | 模式 | 功能 |
|------|------|------|
| `ys{motion}{char}` | n | 添加包围（如 `ysiw"` 给单词加引号） |
| `yss{char}` | n | 添加行包围 |
| `yS{motion}{char}` | n | 添加包围并换行 |
| `ySS{char}` | n | 添加行包围并换行 |
| `S{char}` | v | 为选中内容添加包围 |
| `gS{char}` | v | 为选中内容添加包围并换行 |
| `ds{char}` | n | 删除包围（如 `ds"` 删除引号） |
| `cs{old}{new}` | n | 修改包围（如 `cs"'` 双引号改单引号） |
| `cS{old}{new}` | n | 修改包围并换行 |
| `<C-g>s` | i | 插入模式添加包围 |
| `<C-g>S` | i | 插入模式添加包围并换行 |

**示例**:
```
ysiw(   - 给当前单词添加括号
ysiwb   - 同上（b = 圆括号）
ysiwB   - 给当前单词添加花括号
cst<div>- 将标签改为 <div>
```

---

### 5. indentline.lua
**插件**: [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)

显示缩进参考线，帮助识别代码层级结构。

**功能**:
- 显示缩进竖线
- 高亮当前缩进层级（scope）
- 支持多种文件类型排除（如 dashboard、help 等）

**说明**: 无需快捷键，自动显示。

---

### 6. flash.lua
**插件**: [flash.nvim](https://github.com/folke/flash.nvim)

类似 Vim 的 easymotion，快速跳转到屏幕任意位置。

**快捷键**:

| 按键 | 模式 | 功能 |
|------|------|------|
| `s` | n/x/o | 开始 Flash 跳转 |
| `S` | n/x/o | Treesitter 节点选择 |
| `r` | o | Remote Flash（操作对象） |
| `R` | o/x | Treesitter 搜索 |
| `<C-s>` | c | 切换搜索时的 Flash 模式 |

**使用方式**:
1. 按 `s` 后输入目标字符
2. 屏幕会显示标签（如 `a`, `s`, `d`）
3. 按对应标签跳转到目标位置

---

### 7. multicursors.lua
**插件**: [multicursors.nvim](https://github.com/smoka7/multicursors.nvim)

多光标编辑，同时编辑多处相同文本。

**快捷键**:

| 按键 | 模式 | 功能 |
|------|------|------|
| `<leader>m` | n/v | 为当前单词/选中内容创建多光标选择 |

**命令**:
- `:MCstart` - 开始多光标模式
- `:MCvisual` - 从可视模式开始
- `:MCclear` - 清除所有选择
- `:MCpattern` - 按模式匹配创建选择

**说明**: 进入多光标模式后，使用 Hydra 菜单进行操作。

---

### 8. hlslens.lua
**插件**: [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens)

增强的搜索高亮，显示匹配数量和位置。

**快捷键**:

| 按键 | 模式 | 功能 |
|------|------|------|
| `n` | n | 下一个匹配（带高亮） |
| `N` | n | 上一个匹配（带高亮） |
| `*` | n | 高亮当前单词（向前） |
| `#` | n | 高亮当前单词（向后） |
| `g*` | n | 部分匹配当前单词（向前） |
| `g#` | n | 部分匹配当前单词（向后） |

**功能**: 在命令行显示当前匹配的位置（如 `[2/10]`）。

---

### 9. rainbow-delimiters.lua
**插件**: [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)

彩虹括号，用不同颜色区分匹配的括号层级。

**说明**: 无需快捷键，自动高亮匹配的括号对。

---

### 10. todo-comments.lua
**插件**: [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)

高亮并快速跳转 TODO、FIXME 等注释标记。

**支持的关键词**:
- `TODO` - 待办事项
- `FIX`/`FIXME`/`BUG` - 需要修复的问题
- `HACK` - 临时解决方案
- `WARN`/`WARNING`/`XXX` - 警告
- `PERF`/`OPTIM` - 性能优化
- `NOTE`/`INFO` - 备注信息
- `TEST` - 测试相关

**快捷键**:

| 按键 | 模式 | 功能 |
|------|------|------|
| `]t` | n | 跳到下一个 todo 注释 |
| `[t` | n | 跳到上一个 todo 注释 |
| `<leader>xt` | n | 在 Trouble 中显示所有 todos |
| `<leader>xT` | n | 在 Trouble 中显示 TODO/FIX/FIXME |
| `<leader>st` | n | 在 Telescope 中搜索 todos |
| `<leader>sT` | n | 在 Telescope 中搜索 TODO/FIX/FIXME |

---

## 配置开关

所有编辑器插件默认启用。如需禁用某个插件，可在对应插件文件中设置 `enabled = false`。

---

## 文件结构

```
lua/plugins/editor/
├── init.lua              # 插件入口，统一导入
├── treesitter.lua        # 语法高亮与解析
├── autopairs.lua         # 自动括号
├── comment.lua           # 注释
├── surround.lua          # 环绕操作
├── indentline.lua        # 缩进线
├── flash.lua             # 快速跳转
├── multicursors.lua      # 多光标
├── hlslens.lua           # 搜索高亮
├── rainbow-delimiters.lua # 彩虹括号
└── todo-comments.lua     # Todo 注释
```

每个文件都是独立的 Lazy.nvim 插件 spec，返回一个插件配置 table。
