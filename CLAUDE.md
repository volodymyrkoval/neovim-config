# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modern Neovim configuration using Lua and the Lazy.nvim plugin manager. The configuration follows a modular architecture where each plugin has its own configuration file in `lua/plugins/`.

## Architecture

### Plugin Management
- **Plugin Manager**: Lazy.nvim with lazy loading and version locking via `lazy-lock.json`
- **Plugin Structure**: Each plugin configuration is a separate file in `lua/plugins/` that returns a table
- **Auto-loading**: All files in `lua/plugins/` are automatically imported via `{ import = "plugins" }`

### Key Files
- `init.lua`: Main entry point with editor settings and leader key configuration
- `lua/config/lazy.lua`: Lazy.nvim bootstrap and setup
- `lua/plugins/*.lua`: Individual plugin configurations (one file per plugin/feature)
- `lazy-lock.json`: Plugin version lockfile for reproducible installations

## Common Commands

### Plugin Management
```bash
# Open Lazy.nvim UI (from within Neovim)
:Lazy

# Update plugins
:Lazy update

# Sync plugins (install, clean, update)
:Lazy sync

# Check plugin health
:Lazy health
```

### LSP and Formatting
```bash
# Open Mason UI (from within Neovim)
:Mason

# Format current buffer (or use keymap)
:lua vim.lsp.buf.format()
```

## Development Patterns

### Adding a New Plugin
Create a new file in `lua/plugins/` that returns a plugin specification:
```lua
return {
    "author/plugin-name",
    config = function()
        -- Plugin configuration
    end
}
```

### Plugin Configuration Pattern
All plugin files follow this structure:
1. Return a table (or array of tables for multiple related plugins)
2. Include plugin name as first element
3. Add configuration in `config` function
4. Define keymaps within the plugin file
5. Specify dependencies if needed

### Current Language Support
- **Lua**: Full LSP with lua_ls, formatting with StyLua
- **TypeScript/JavaScript**: tsserver LSP, ESLint diagnostics, Prettier formatting

## Key Mappings

- **Leader**: `<Space>`
- **LSP**: `gd` (definition), `gr` (references), `K` (hover), `<leader>ca` (code actions)
- **File Navigation**: `<leader>ff` (find files), `<leader>fg` (grep), `<C-a>1` (Neo-tree toggle)
- **Formatting**: `<leader>gf` (format buffer)

## Important Configuration Details

### Editor Settings
- Tab width: 4 spaces
- Expand tabs to spaces
- Line numbers enabled

### Plugin Dependencies
- Mason → Mason-LSPConfig → nvim-lspconfig (LSP setup chain)
- None-ls depends on Mason-null-ls for tool installation
- None-ls uses none-ls-extras.nvim for ESLint integration (diagnostics and code actions)
- Neo-tree requires nui.nvim and nvim-web-devicons

### Auto-installation
- Treesitter parsers auto-install when opening files
- Mason tools (LSP servers, formatters) auto-install via mason-lspconfig and mason-null-ls