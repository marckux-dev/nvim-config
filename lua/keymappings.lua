local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- =======================================
-- Insert mode mappings
-- =======================================
vim.keymap.set("i", "(", "()<Esc>i")
vim.keymap.set("i", "[", "[]<Esc>i")
vim.keymap.set("i", "{", "{}<Esc>i")
-- Motions
-- Move cursor in insert mode using Ctrl + h/j/k/l
vim.keymap.set('i', '<C-h>', '<Left>',  { desc = 'Move left in insert mode' })
vim.keymap.set('i', '<C-j>', '<Down>',  { desc = 'Move down in insert mode' })
vim.keymap.set('i', '<C-k>', '<Up>',    { desc = 'Move up in insert mode' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move right in insert mode' })
-- Insert characters at the end of the current line
vim.keymap.set('i', '<A-;>', t('<Esc>A;'), { desc = 'Insert semicolon at the end of line'});
vim.keymap.set('i', '<A-,>', t('<Esc>A,'), { desc = 'Insert comma at the end of line'});
vim.keymap.set('i', '<A-.>', t('<Esc>A.'), { desc = 'Insert dot at the end of line'});


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
--  Macros
-- ==========================
vim.keymap.set("n", "<leader>h", ":noh<CR>", { desc = "Clear search"})
vim.keymap.set("n", "<leader>{", t("a{<CR>}<Esc>ko"), { desc = "Keys block" })
vim.keymap.set("n", "<leader>(", t("a(<CR>)<Esc>ko"), { desc = "Parentheses block" })
vim.keymap.set("n", "<leader>[", t("a[<CR>]<Esc>ko"), { desc = "Brackets block" })
vim.keymap.set("n", 
  "<leader>I", t("oimport {  } from '';<Esc>^f{la"), 
  { desc = "Insert import template" }
)

-- ==========================
--  Tab and Buffer Management
-- ==========================
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })

-- ==========================
--  Wrappers
-- ==========================
vim.keymap.set("v", "<leader>w{", "c{<C-r>\"}<Esc>", { desc = "Wrap with {}" })
vim.keymap.set("v", "<leader>w(", "c(<C-r>\")<Esc>", { desc = "Wrap with ()" })
vim.keymap.set("v", "<leader>w[", "c[<C-r>\"]<Esc>", { desc = "Wrap with []" })


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
vim.keymap.set("n", "<F5>", ToggleCWD, { desc = "Toggle CWD between initial and file"})


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

vim.keymap.set("n", "<leader>ct", ToggleCatppuccinTheme, { desc = "Toggle Catppuccin light/dark" })

