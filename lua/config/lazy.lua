-- ============================================================================
-- KEYWORDS: post-setup, colorscheme, tema, theme, devicons, neo-tree
-- ⚠️ ARCHIVO HUÉRFANO (dead code): ningún require() lo carga actualmente.
-- El colorscheme lo aplica plugins/catppuccin.lua y neo-tree se configura en
-- plugins/neo-tree.lua. Candidato a borrar (delete).
-- ============================================================================

vim.cmd.colorscheme("catppuccin-mocha")
require("nvim-web-devicons").setup({ default = true })
require("neo-tree").setup({})
