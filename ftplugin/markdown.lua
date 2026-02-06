-- path: /home/marckux/.config/nvim/ftplugin/markdown.lua

-- 1. Activar el corrector ortográfico
vim.opt_local.spell = true

-- 2. Configurar el idioma (esto disparará la descarga si no existe)
vim.opt_local.spelllang = { "es", "en" } -- Sugerencia: añade "en" si usas términos técnicos

-- 3. Definir tu archivo personal de Obsidian como fuente de 'spell'
local spell_path = vim.fn.stdpath("config") .. "/spell/obsidian-es.utf-8.add"
vim.opt_local.spellfile = spell_path

-- 4. SOLUCIÓN AL ":set dictionary?": 
-- Esto añade tu archivo de Obsidian a la lista de diccionarios de Neovim
vim.opt_local.dictionary:append(spell_path)
