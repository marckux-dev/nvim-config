local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- =======================================
-- Insert mode mappings
-- =======================================
local function pair_open(open, close)
  return function()
    return open .. close .. "<C-g>U<Left>"
  end
end

local function pair_close(close)
  return function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local next_char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)
    if next_char == close then
      return "<C-g>U<Right>"
    end
    return close
  end
end

vim.keymap.set("i", "(", pair_open("(", ")"), { expr = true })
vim.keymap.set("i", "[", pair_open("[", "]"), { expr = true })
vim.keymap.set("i", "{", pair_open("{", "}"), { expr = true })
vim.keymap.set("i", ")", pair_close(")"), { expr = true })
vim.keymap.set("i", "]", pair_close("]"), { expr = true })
vim.keymap.set("i", "}", pair_close("}"), { expr = true })
-- Motions
-- Move cursor in insert mode using Ctrl + h/j/k/l
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left in insert mode" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down in insert mode" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up in insert mode" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right in insert mode" })
-- Insert characters at the end of the current line
vim.keymap.set("i", "<A-;>", t("<Esc>A;"), { desc = "Insert semicolon at the end of line" })
vim.keymap.set("i", "<A-,>", t("<Esc>A,"), { desc = "Insert comma at the end of line" })
vim.keymap.set("i", "<A-.>", t("<Esc>A."), { desc = "Insert dot at the end of line" })
-- Unselect in normal mode
vim.keymap.set("n", "<Esc><Esc>", ":noh<CR>", { silent = true, desc = "Unselect text" })

-- ==========================
--  Leader Key
-- ==========================
vim.g.mapleader = " "
-- File operations
vim.keymap.set("n", "<leader>ww", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>wa", ":wa<CR>", { desc = "Save all files" })
vim.keymap.set("n", "<leader>wqq", ":wq<CR>", { desc = "Save & quit" })
vim.keymap.set("n", "<leader>wqa", ":wqa<CR>", { desc = "Save all & quit" })

-- ==========================
--  Tab and Buffer Management
-- ==========================
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>qq", ":q<CR>",  { desc = "Cerrar ventana" })
vim.keymap.set("n", "<Tab>", ":bn<CR>", { desc = "Next buffer"})
vim.keymap.set("n", "<S-Tab>", ":bp<CR>", { desc = "Previous buffer" })

-- ==========================
--  Wrappers
-- ==========================
-- vim.keymap.set("v", "<leader>w{", 'c{<C-r>"}<Esc>', { desc = "Wrap with {}" })
-- vim.keymap.set("v", "<leader>w(", 'c(<C-r>")<Esc>', { desc = "Wrap with ()" })
-- vim.keymap.set("v", "<leader>w[", 'c[<C-r>"]<Esc>', { desc = "Wrap with []" })

--- =========================
--- Copy to clipboard
--- =========================
vim.keymap.set("n", "<leader>y", ":w !wslclip<CR>", { desc = "To Clipboard" })
vim.keymap.set("v", "<leader>y", ":'<'>w !wslclip<CR>", { desc = "Copy selection to Windows Clipboard" })

-- ==========================
--  Terminal
-- ==========================
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- =======================================
-- Toggle CWD
-- =======================================
local initial_cwd = vim.fn.getcwd()
function ToggleCWD()
	if vim.fn.getcwd() == initial_cwd then
		vim.cmd("cd %:p:h")
	else
		vim.cmd("cd " .. initial_cwd)
	end
	print("Current directory: " .. vim.fn.getcwd())
end

vim.keymap.set("n", "<F5>", ToggleCWD, { desc = "Toggle CWD between initial and file" })

-- =======================================
-- Toggle Catppuccin theme (light/dark)
-- =======================================
local current_theme = "mocha"

function ToggleCatppuccinTheme()
	if current_theme == "mocha" then
		vim.cmd("colorscheme catppuccin-latte")
		current_theme = "latte"
		vim.notify("🌤 Switched to Catppuccin Latte (Light)")
	else
		vim.cmd("colorscheme catppuccin-mocha")
		current_theme = "mocha"
		vim.notify("🌙 Switched to Catppuccin Mocha (Dark)")
	end
end

-- ==========================
--  Diccionario / Spell
-- ==========================
vim.keymap.set("n", "<leader>sr", ":ObsidianRefresh<CR>", {
	silent = true,
	desc = "Sincronizar diccionario Obsidian",
})

-- ==========================
--  Toggle Catppuccin
-- ==========================
vim.keymap.set("n", "<leader>ct", ToggleCatppuccinTheme, { desc = "Toggle Catppuccin light/dark" })
