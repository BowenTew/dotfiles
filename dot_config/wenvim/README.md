# AeonVim - Neovim Configuration

A modular Neovim configuration framework with version pinning and rollback support.

## 🎯 Design Philosophy

| Source | Strengths Borrowed |
|--------|-------------------|
| **AstroNvim** | Beautiful UI design, modular structure |
| **LazyVim** | Sensible defaults, flexible extension mechanism |
| **LunarVim** | Isolated runtime environment, version pinning |
| **NormalNvim** | Stability-first, hot-reload, rollback mechanism |
| **NvChad** | Blazing fast startup, rich themes |
| **Ecovim** | Frontend development optimization, AI integration |

## 📁 Directory Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/
│   │   ├── global.lua          # Global configuration object
│   │   ├── options.lua         # Base options
│   │   ├── keymaps.lua         # Key mappings
│   │   ├── autocmds.lua        # Autocommands
│   │   ├── lazy.lua            # Plugin manager setup
│   │   └── lsp/                # LSP server configurations
│   │       ├── init.lua        # Server registry
│   │       ├── clangd.lua      # C/C++
│   │       ├── go.lua          # Go
│   │       ├── lua_ls.lua      # Lua
│   │       ├── rust.lua        # Rust
│   │       ├── typescript.lua  # TypeScript
│   │       └── vue.lua         # Vue
│   ├── plugins/                # Plugin specs
│   │   ├── init.lua            # Plugin entry point
│   │   ├── base/               # Base dependencies
│   │   ├── editor/             # Editor enhancements
│   │   ├── finder/             # Search / Finder
│   │   ├── git/                # Git integration
│   │   ├── lsp/                # LSP / Formatting / Linting
│   │   ├── ui/                 # UI components
│   │   └── languages/          # Language-specific plugins
│   ├── utils/                  # Utility functions
│   │   ├── icons.lua           # Icon definitions
│   │   ├── globals.lua         # Global helpers
│   │   ├── functions.lua       # Utility functions
│   │   └── distro.lua          # (removed, use git directly)
│   ├── internal/               # Internal modules
│   │   └── cursorword.lua      # Cursor word highlighting
│   └── lazy_snapshot.lua       # (deprecated, replaced by lazy-lock.json)
└── after/queries/              # Treesitter query overrides
```

## ⚙️ Global Configuration

Customize via the `AeonVim` object:

```lua
-- lua/config/global.lua
_G.AeonVim = {
  version = "0.1.0",
  colorscheme = "base46-vscode_dark",

  -- Icon configuration
  icons = require("utils.icons"),

  -- Key configuration
  keys = {
    leader = " ",
    localleader = ",",
  },
}
```

All plugins are enabled by default. To disable a plugin, set `enabled = false` in its spec file.

## ⌨️ Key Mappings

### Basic Operations
| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<C-s>` | Save file |
| `<C-q>` | Quit |
| `<Esc>` / `<leader>h` | Clear search highlights |
| `jk` / `jj` | Exit insert mode |
| `H` / `L` | Start / end of line |
| `<A-j>` / `<A-k>` | Move line (normal/insert/visual) |
| `<leader>y` / `<leader>Y` | Copy to system clipboard |
| `<leader>p` / `<leader>P` | Paste from yank register |
| `<leader>d` / `<leader>c` | Black-hole delete / change |

### Window Navigation
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate windows (includes terminal mode) |
| `<C-Arrow>` | Resize window |
| `<leader>-` | Horizontal split |
| `<leader>\|` | Vertical split |
| `<leader>xs` | Close split |
| `<leader>se` | Equalize windows |

### File Operations
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file tree (Neo-tree) |
| `<leader>o` | Focus file tree |
| `<leader>ge` | Git status file tree |
| `<leader>be` | Buffer file tree |
| `<leader>ff` / `<leader><space>` | Find files (Telescope) |
| `<leader>fF` | Find files (include hidden) |
| `<leader>fg` | Find git files |
| `<leader>fr` | Recent files |
| `<leader>/` / `<leader>sg` | Global search (live_grep) |
| `<leader>sw` | Search current word |
| `<leader>,` | Switch buffer |

### Buffers
| Key | Action |
|-----|--------|
| `<leader>fb` | Buffer list |
| `<leader>bd` | Delete current buffer (`<C-d>` / `dd` in Telescope) |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Show references |
| `gI` | Go to implementation |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename |
| `<leader>cf` | Format |
| `<leader>ss` | Document symbols |
| `<leader>sS` | Workspace symbols |

### Diagnostics
| Key | Action |
|-----|--------|
| `[d` / `]d` | Diagnostic navigation |
| `[e` / `]e` | Error navigation |
| `[w` / `]w` | Warning navigation |
| `<leader>sd` | All diagnostics (Telescope) |
| `<leader>sD` | Buffer diagnostics |

### Quick Jump (flash.nvim)
| Key | Action |
|-----|--------|
| `s` | Flash jump |
| `S` | Flash Treesitter |
| `r` (Operator) | Remote Flash |
| `R` (Operator/Visual) | Treesitter Search |
| `<C-s>` (Cmd) | Toggle Flash Search |

### Session Management (persistence.nvim)
| Key | Action |
|-----|--------|
| `<leader>qs` | Restore session for current dir |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Don't save current session |

### Plugin Version
| Key | Action |
|-----|--------|
| `<leader>pS` | Restore plugins from lockfile |

## 🚀 Quick Start

### Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone configuration
git clone <your-repo> ~/.config/nvim

# Launch Neovim
nvim
```

### First Launch

1. lazy.nvim will install automatically
2. All plugins will be downloaded
3. Treesitter grammars will be installed
4. LSP servers can be installed via `:Mason`

## 🔧 Customization

### Adding a New Plugin

Create a new spec file under `lua/plugins/`:

```lua
-- lua/plugins/myplugin.lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy",
    config = function()
      require("plugin-name").setup({
        -- configuration
      })
    end,
  },
}
```

### Changing Keymaps

Edit `lua/config/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>xx", "<cmd>MyCommand<CR>", { desc = "My description" })
```

### Changing Options

Edit `lua/config/options.lua`:

```lua
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
```

## 📦 Pre-configured Plugins

### UI
- [x] **base46** / tokyonight.nvim / catppuccin / onedark / yorumi — Color schemes
- [x] alpha-nvim — Startup dashboard
- [x] noice.nvim — Notification / cmdline / messages UI (replaces nvim-notify)
- [x] noice.nvim — Cmdline / message UI
- [x] nvim-web-devicons — File icons
- [x] neo-tree.nvim — File tree explorer
- [x] bufferline.nvim — Buffer tabs
- [x] lualine.nvim — Statusline
- [x] which-key.nvim — Keymap hints
- [x] toggleterm.nvim — Floating terminal

### Editor
- [x] nvim-treesitter — Syntax highlighting / folding / text objects
- [x] blink.cmp — Async completion engine
- [x] LuaSnip — Snippet engine
- [x] nvim-autopairs — Auto bracket pairing
- [x] Comment.nvim — Quick commenting
- [x] nvim-surround — Surround text objects (v4+ simplified config)
- [x] indent-blankline.nvim — Indent guides
- [x] flash.nvim — Fast jumping
- [x] multicursors.nvim — Multi-cursor editing (uses nvimtools/hydra.nvim)
- [x] hlslens.nvim — Search highlight enhancement
- [x] rainbow-delimiters.nvim — Rainbow brackets
- [x] todo-comments.nvim — TODO highlighting

### Finder
- [x] telescope.nvim — Fuzzy finder
- [x] telescope-fzf-native.nvim — fzf sorter

### LSP / Formatting / Linting
- [x] nvim-lspconfig — LSP client configuration
- [x] mason.nvim — LSP / DAP / tool installer
- [x] mason-lspconfig.nvim — Mason ↔ lspconfig bridge
- [x] mason-tool-installer.nvim — Auto tool installation
- [x] conform.nvim — Code formatting
- [x] nvim-lint — Code linting

### Git
- [x] gitsigns.nvim — Git signs / blame
- [x] diffview.nvim — Diff viewer
- [x] lazygit.nvim — Lazygit integration
- [x] git-conflict.nvim — Conflict resolution

### Terminal
- [x] toggleterm.nvim — Terminal management

### Session Management
- [x] persistence.nvim — Auto session save / restore

## 🌐 Pre-configured LSP Servers

| Language | Server | Config File |
|----------|--------|-------------|
| C/C++ | `clangd` | `lua/config/lsp/clangd.lua` |
| Go | `gopls` | `lua/config/lsp/go.lua` |
| Lua | `lua_ls` | `lua/config/lsp/lua_ls.lua` |
| Rust | `rust_analyzer` | `lua/config/lsp/rust.lua` |
| TypeScript | `ts_ls` | `lua/config/lsp/typescript.lua` |
| Vue | `vue_ls` | `lua/config/lsp/vue.lua` |

To add a new server: create a config file under `lua/config/lsp/` and register it in `lua/config/lsp/init.lua`.

## 🎨 Color Schemes

Built-in themes:
- `base46-vscode_dark` (default)
- `tokyonight-night` / `tokyonight-storm` / `tokyonight-day`
- `catppuccin`
- `onedark`
- `yorumi`

Switch theme:
```vim
:colorscheme catppuccin
```
Or run `:Telescope colorscheme` (`<leader>uC`) to preview and switch.

## 🔄 Version Management

AeonVim uses lazy.nvim's native **lockfile** mechanism for deterministic plugin versioning.

### How It Works

lazy.nvim automatically maintains a `lazy-lock.json` file in your config directory. Commit this file to git to ensure consistent plugin versions across all machines.

| Scenario | Action |
|----------|--------|
| New machine / fresh clone | Plugins install at the exact versions recorded in `lazy-lock.json` |
| Update plugins | Run `:Lazy update`, then `git commit lazy-lock.json` |
| Sync with team | `git pull` then `:Lazy restore` to match committed versions |
| Check for updates | `:Lazy check` shows available updates without installing |

### Management Commands

| Command | Description |
|---------|-------------|
| `:Lazy update` | Update plugins to latest versions |
| `:Lazy restore` | Restore plugins to versions in `lazy-lock.json` |
| `:Lazy sync` | Install missing + remove unused + restore versions |

## 📚 References

- [AstroNvim](https://github.com/AstroNvim/AstroNvim)
- [LazyVim](https://github.com/LazyVim/LazyVim)
- [LunarVim](https://github.com/LunarVim/LunarVim)
- [NormalNvim](https://github.com/NormalNvim/NormalNvim)
- [NvChad](https://github.com/NvChad/NvChad)
- [Ecovim](https://github.com/ecosse3/nvim)

## 📝 License

MIT
