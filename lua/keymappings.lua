-- =======================================
-- Insert mode mappings
-- =======================================
vim.keymap.set("i", "(", "()<Esc>i")
vim.keymap.set("i", "[", "[]<Esc>i")
vim.keymap.set("i", "{", "{}<Esc>i")

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
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
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
vim.keymap.set("n", "<leader>tt", ":tab ball<CR>", { desc = "Open all buffers in tabs" })
vim.keymap.set("n", "<leader>th", ":-tabmove<CR>", { desc = "Move tab left" })
vim.keymap.set("n", "<leader>tl", ":+tabmove<CR>", { desc = "Move tab right" })
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

