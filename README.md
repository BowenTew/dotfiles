# Dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

### Install chezmoi

```bash
# macOS
brew install chezmoi

# Linux
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### Clone and apply

```bash
chezmoi init --apply <your-repo-url>
```

### On a new machine

```bash
# 1. Install chezmoi
# 2. Init from this repo
chezmoi init --apply https://github.com/<user>/<repo>.git

# Or via SSH
chezmoi init --apply git@github.com:<user>/<repo>.git
```

## Daily Workflow

| Command | Description |
|---------|-------------|
| `chezmoi edit <file>` | Edit a managed file in source dir |
| `chezmoi apply` | Apply changes from source to target |
| `chezmoi diff` | Show pending changes |
| `chezmoi status` | List managed files and their status |
| `chezmoi add <file>` | Add a new file to management |
| `chezmoi re-add <file>` | Re-capture target file changes |
| `chezmoi cd` | Jump to source directory |
| `chezmoi doctor` | Check for problems |

## Common Scenarios

### Edit config and apply

```bash
# Edit in source dir (opens $EDITOR)
chezmoi edit ~/.config/nvim/init.lua

# Apply to target
chezmoi apply

# Or edit + apply in one shot
chezmoi edit --apply ~/.config/nvim/init.lua
```

### Target file changed (e.g. lazy-lock.json updated)

```bash
# Re-capture the change into source dir
chezmoi re-add ~/.config/nvim/lazy-lock.json

# Or re-add all changed files
chezmoi re-add
```

### Add a new dotfile

```bash
chezmoi add ~/.config/some-app/config.toml
chezmoi edit ~/.config/some-app/config.toml
chezmoi apply
```

### See what would change

```bash
chezmoi diff
chezmoi apply --dry-run
```

### Update from upstream

```bash
chezmoi update
# Equivalent to:
#   chezmoi git pull
#   chezmoi apply
```

## Directory Layout

```
~/.local/share/chezmoi/
├── README.md              # This file
├── dot_config/            # ~/.config/
│   └── nvim/              # Neovim config (AeonVim)
│       ├── init.lua
│       ├── lua/
│       └── lazy-lock.json
└── ...                    # Other dotfiles
```

- `dot_` prefix → `.` in target (e.g. `dot_config` → `~/.config`)
- `private_` prefix → sets 0600 permissions
- `executable_` prefix → sets executable bit
- `symlink_` prefix → creates symlink instead of copy
- `literal_` prefix → disables attribute prefix parsing

## Templating

Files with `.tmpl` extension are processed as Go templates:

```bash
# Create a template
chezmoi add --autotemplate ~/.gitconfig

# Use variables
chezmoi data              # Show available template data
chezmoi execute-template  # Test template rendering
```

Example template (`dot_gitconfig.tmpl`):
```
[user]
    name = {{ .name }}
    email = {{ .email }}
```

## Machine-Specific Config

Use `chezmoi.toml` for per-machine settings:

```bash
chezmoi init
# Edit ~/.config/chezmoi/chezmoi.toml
chezmoi data  # Verify
```

Or use `.chezmoi.toml.tmpl` in source dir for templated config.

## Secrets

### 1Password
```bash
chezmoi edit --1password <file>
```

### Bitwarden
```bash
chezmoi edit --bitwarden <file>
```

### age encryption
```bash
# Encrypt a file
chezmoi encrypt <file>

# Auto-decrypt on apply
chezmoi apply
```

## Git Workflow

```bash
chezmoi cd                    # Enter source dir
git add .
git commit -m "update nvim config"
git push
```

Or from anywhere:
```bash
chezmoi git add .
chezmoi git commit -- -m "update"
chezmoi git push
```

## Resources

- [chezmoi docs](https://www.chezmoi.io/)
- [How-to guides](https://www.chezmoi.io/user-guide/daily-operations/)
- [Templating](https://www.chezmoi.io/user-guide/templating/)
