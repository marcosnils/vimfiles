# Neovim Configuration

A modern, performant Neovim setup focused on Go development, full-stack web development, DevOps/Infrastructure work, and AI-assisted coding.

## Quick Start

This configuration uses Neovim's native package manager (v0.12+). Plugins are automatically managed via `vim.pack.add()` and tracked in `nvim-pack-lock.json`.

**Requirements:**
- Neovim ≥ 0.12
- Git
- Ripgrep (for Telescope grep)
- A Nerd Font (for icons)

## Project Structure

```
~/.config/nvim/
├── init.lua                    # Main configuration file
├── nvim-pack-lock.json        # Plugin lock file
└── lua/
    ├── lsp_autocommands.lua   # LSP automation and event handlers
    └── plugins/
        ├── lsp.lua            # LSP server configurations
        └── syntax.lua         # Treesitter and syntax-related plugins
```

## Key Features

### AI-Assisted Development
- **GitHub Copilot** - AI code suggestions (Ctrl+J to accept)
- **Claude Code** - Claude AI integration for complex tasks
  - `<leader>as` (visual) - Send selection to Claude
  - `<leader>ab` - Add current buffer to Claude context

### Language Server Protocol (LSP)

**Configured Language Servers:**

| Language | Server | Special Features |
|----------|--------|------------------|
| Go | gopls | Gofumpt, code lenses, inlay hints, staticcheck |
| TypeScript/JavaScript | ts_ls | Full inlay hints configuration |
| Bash | bashls | - |
| C/C++ | clangd | - |
| CSS | cssls | - |
| HTML | html | Including templ files |
| HTMX | htmx | - |
| JSON | jsonls | - |
| Lua | lua_ls | Neovim runtime integration |
| Python | pylsp | - |
| Rust | rust_analyzer | - |
| Tailwind CSS | tailwindcss | HTML, templ, JavaScript support |
| TOML | taplo | - |
| Templ | templ | Go template language |
| Terraform | terraformls + tflint | - |
| YAML | yamlls | SchemaStore integration |
| Zig | zls | - |

**LSP Features:**
- Format on save with timeout protection (5000ms)
- Organize imports after save
- Document highlighting on cursor hold
- Code lens refresh automation
- Inlay hints enabled where supported

### Go Development

Extensive Go support with:
- **Gofumpt** formatting
- **Code lenses**: gc_details, generate, govulncheck, test, tidy, upgrade_dependency
- **Inlay hints** for all types
- **Static analysis**: nilness, unused params/variables/writes, useany
- **Staticcheck** enabled
- **Custom commands**:
  - `:GoModTidy` or `F6` - Run go mod tidy
  - `F7` - Run golangci-lint with quickfix integration
- **Auto-format** on write with organize imports

## Essential Keybindings

### Leader Key: `<space>`

### File Navigation & Management

| Key | Action |
|-----|--------|
| `F1` | Toggle Oil file explorer (floating) |
| `Ctrl+P` | Fuzzy find files (including hidden) |
| `Ctrl+F o` | Recent files (cwd only) |
| `Ctrl+F f` | Live grep in project |
| `Ctrl+F b` | Browse open buffers |
| `Ctrl+F c` | Fuzzy search in current buffer |
| `Ctrl+F d` | Browse diagnostics |
| `Ctrl+F h` | Search help tags |

### Buffer Management

| Key | Action |
|-----|--------|
| `Ctrl+X` | Delete buffer (smart) |
| `Ctrl+N` | New empty buffer |
| `F3` / `F4` | Previous/next buffer |
| `<leader><tab>` | Cycle windows |

### LSP Operations

| Key | Action |
|-----|--------|
| `gd` | Go to definition (Telescope) |
| `gD` | Go to declaration |
| `gr` | Show references (Telescope) |
| `gO` | Document symbols |
| `gi` | Go to implementation (Telescope) |
| `K` | Show hover documentation |
| `Ctrl+K` | Signature help |
| `<space>D` | Type definition |
| `<space>e` | Show diagnostic float |
| `<space>rn` | Rename symbol |
| `ga` | Code actions |
| `<space>f` | Format buffer |
| `[d` / `]d` | Previous/next diagnostic |
| `<leader>dv` / `<leader>dh` | Go to definition in split |
| `<leader>ls` | Document symbols |
| `<leader>lS` | Workspace symbols |
| `grl` | Run code lens |
| `gco` | Generate documentation (Neogen) |
| `Alt+N` / `Alt+P` | Next/previous reference |

### Git Operations

| Key | Action |
|-----|--------|
| `<leader>gd` | Preview hunk inline |
| `<leader>gy` | Copy GitHub link (visual/normal) |
| `<leader>gY` | Open GitHub link in browser |

**In Fugitive window:**
- `gp` - Push
- `gP` - Pull with rebase
- `go` - Push and open PR
- `cc` - Commit with sign-off
- `gq` - Close window

### Editing & Text Manipulation

| Key | Action |
|-----|--------|
| `/` | Very magic regex search (`/\v`) |
| `,` | Search word under cursor |
| `<leader><space>` | Clear search highlight |
| `<leader>v` | Select line without newline |
| `<` / `>` (visual) | Indent/unindent and reselect |
| `J` | Join lines without spaces (`gJ`) |
| `Ctrl+Up/Down` | Bubble lines up/down |
| `<leader>st` | Toggle split/join code blocks |
| `<leader>r` | Global search and replace |
| `<leader>y` | Yank to system clipboard |
| `<leader>p` | Paste from system clipboard |
| `<leader>d` | Delete to black hole register |

### Treesitter Text Objects

| Key | Action |
|-----|--------|
| `af` / `if` | Function outer/inner |
| `ac` / `ic` | Conditional outer/inner |
| `aa` / `ia` | Parameter outer/inner |
| `av` / `iv` | Variable outer/inner |
| `<leader>a` / `<leader>A` | Swap parameters |
| `]]` / `[[` | Next/previous function |
| `Ctrl+Space` | Expand selection incrementally |
| `<BS>` | Shrink selection |

### Utility Toggles

| Key | Action |
|-----|--------|
| `F5` | Toggle line wrap |
| `F6` | Toggle list characters |
| `<leader>py` | Copy current file path |
| `<leader>xx` | Send diagnostics to quickfix |

## Design Philosophy

This configuration emphasizes:

1. **Performance** - Native package manager, lazy loading where appropriate
2. **Go-first development** - Extensive gopls configuration and tooling
3. **Modern web development** - Full TypeScript, HTML, CSS, Tailwind support
4. **DevOps workflow** - Terraform, Docker, YAML, shell scripting
5. **AI assistance** - Copilot + Claude integration
6. **Git-centric** - Fugitive, gitsigns, gitlinker for GitHub workflow
7. **Fuzzy everything** - Telescope for files, grep, symbols, diagnostics
8. **Minimal UI** - Dark theme, clean statusline, dropdown menus

## Colorscheme

**vim-distinguished** - A dark, elegant colorscheme with good contrast

## License

Personal configuration - feel free to use as inspiration for your own setup.
