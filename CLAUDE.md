# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration for a polyglot development environment. Plugin manager: **lazy.nvim** (auto-bootstrapped in `init.lua`). All plugin specs live under `lua/plugins/` and are loaded via `require("lazy").setup("plugins")`.

## Initialization Order

`init.lua` loads in this sequence:
1. `lua/basic.lua` — core Vim options
2. `lua/keymappings.lua` — global keybindings
3. `lua/commands.lua` — user-defined commands (`:MakeTags`, `:NgGen`, `:ObsidianRefresh`, `:MavenTest`, `:FlutterWatch`, `:FormatHTML`)
4. `lua/snippets.lua` — LuaSnip snippet setup
5. lazy.nvim bootstrap + plugin loading from `lua/plugins/`

Language-specific overrides go in `ftplugin/` (e.g., `ftplugin/java.lua` for full JDTLS setup).

## Adding/Modifying Plugins

Each file in `lua/plugins/` returns a table (or list of tables) of lazy.nvim plugin specs. Create a new file for each logical group. After changes, run `:Lazy sync` inside Neovim — `lazy-lock.json` is the lockfile.

Preferred lazy-loading triggers used in this config:
- `event = "InsertEnter"` — completion sources
- `event = { "BufReadPre", "BufNewFile" }` — editor enhancements
- `cmd = { "..." }` — command-triggered plugins (dadbod, neo-tree)
- `ft = { "..." }` — filetype-triggered (jdtls for Java)

## Key Architectural Patterns

### Completion (`lua/plugins/completion.lua`)
Sources are priority-ordered: LSP (1000) > LuaSnip (750) > Buffer (500) > Dictionary (250) > Path (100). SQL buffers swap in `vim-dadbod-completion` at 1000. Markdown enables the Spanish/English Obsidian dictionary (`spell/obsidian-es.utf-8.add`). Add new sources by appending to the `sources` table inside the `config` function.

### LSP (`lua/plugins/lsp.lua`)
Uses mason → mason-lspconfig → lspconfig chain. All servers share a common `on_attach` (keymaps) and `capabilities` (from nvim-cmp). To add a new server: install via Mason, then add it to the `servers` table in `lsp.lua`. Java is intentionally excluded here — it's handled entirely by `ftplugin/java.lua` with nvim-jdtls.

### Java (`ftplugin/java.lua`)
JDTLS is launched per-project. Depends on:
- `~/.local/share/lombok/lombok.jar`
- `~/.sdkman/candidates/java/current` (Java binary)
- Mason-installed `jdtls`, `java-debug-adapter`, `java-test`
- Workspace cache at `~/.cache/jdtls-workspace/<project-name>`

### Flutter TMUX Hot Reload (`lua/commands.lua`)
`:FlutterWatch [pane]` toggles a `BufWritePost *.dart` autocmd that sends `r` (hot reload) to a TMUX pane. Requires an active `flutter run` session in that pane.

### Python (`lua/plugins/lsp.lua` — pyright section)
Auto-detects virtualenvs by walking up from the file's directory, checking for `.venv`, `venv`, `env`, `.env`. Jupyter notebooks use a dedicated venv at `~/.venv/jupyter/`.

### Which-Key Groups (`lua/plugins/wich-key.lua`)
Leader key group prefixes are registered here. When adding a new `<leader>X` family of mappings, add the group label in this file so it appears in the which-key popup.

## Leader Key Map (top-level groups)

| Prefix | Group |
|--------|-------|
| `<leader>w` | Write/quit |
| `<leader>b` | Buffers |
| `<leader>f` | Files / Telescope |
| `<leader>e` | LSP diagnostics & actions |
| `<leader>g` | Git (fugitive + gitsigns) |
| `<leader>t` | Tests (vim-test) |
| `<leader>d` | DAP debugger |
| `<leader>j` | Java refactoring / Jupyter |
| `<leader>D` | Database (dadbod) |
| `<leader>F` | Flutter (visual mode) |

## Spell / Dictionary

Custom dictionary at `spell/obsidian-es.utf-8.add`. Run `:ObsidianRefresh` to async-sync new words from the Obsidian vault. Dictionary is also used as a cmp source in Markdown buffers.

## Known Environment Dependencies

- **WSL2** — `<leader>y` pipes to `clip.exe`; Flutter TMUX integration assumes WSL terminal.
- **TMUX** — required for vim-test (vimux runner) and `:FlutterWatch`.
- **SDKMAN** at `~/.sdkman` — Java binary discovery for JDTLS.
- **Lombok JAR** at `~/.local/share/lombok/lombok.jar`.
- **Jupyter venv** at `~/.venv/jupyter/` — used by molten-nvim.
