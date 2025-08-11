# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modern Neovim configuration using Lua and the Lazy.nvim plugin manager. The configuration follows a modular architecture where plugins are organized by category in `lua/plugins/`.

## Architecture

### Plugin Management
- **Plugin Manager**: Lazy.nvim with lazy loading and version locking via `lazy-lock.json`
- **Plugin Structure**: Plugins are organized by category in `lua/plugins/` (ui.lua, lsp.lua, completions.lua, editor.lua)
- **Auto-loading**: All files in `lua/plugins/` are automatically imported via `{ import = "plugins" }`

### Key Files
- `init.lua`: Main entry point with comprehensive editor settings
- `lua/config/lazy.lua`: Lazy.nvim bootstrap and setup
- `lua/config/keymaps.lua`: Centralized keymap configurations
- `lua/plugins/ui.lua`: UI-related plugins (colorscheme, statusline, file explorer)
- `lua/plugins/lsp.lua`: LSP configuration and tools
- `lua/plugins/completions.lua`: Auto-completion system
- `lua/plugins/editor.lua`: Editor enhancement plugins
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
Add plugin specifications to the appropriate category file in `lua/plugins/`:
```lua
-- In lua/plugins/ui.lua, lsp.lua, completions.lua, or editor.lua
return {
    -- Existing plugins...
    {
        "author/plugin-name",
        config = function()
            -- Plugin configuration
        end
    }
}
```

### Plugin Configuration Pattern
Plugin category files follow this structure:
1. Return a table containing arrays of plugin specifications
2. Group related plugins by functionality
3. Add configuration in `config` functions
4. Keymaps are centralized in `lua/config/keymaps.lua`
5. Specify dependencies as needed

### Current Language Support
- **Lua**: Full LSP with lua_ls, formatting with StyLua, intelligent completion
- **TypeScript/JavaScript**: tsserver LSP, ESLint diagnostics, Prettier formatting, intelligent completion

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
- Smart indentation and case-sensitive search
- Clipboard integration with system clipboard
- Persistent undo history
- Modern UI enhancements (scrolloff, signcolumn, etc.)

### Plugin Dependencies
- Mason → Mason-LSPConfig → nvim-lspconfig (LSP setup chain)
- None-ls depends on Mason-null-ls for tool installation
- None-ls uses none-ls-extras.nvim for ESLint integration (diagnostics and code actions)
- Neo-tree requires nui.nvim and nvim-web-devicons
- nvim-cmp completion system with LuaSnip and friendly-snippets

### Auto-installation
- Treesitter parsers auto-install when opening files
- Mason tools (LSP servers, formatters) auto-install via mason-lspconfig and mason-null-ls
- Completion sources automatically configured for LSP, buffer, path, and snippets