
-- =======================================
-- Basic settings
-- =======================================
vim.opt.compatible = false
vim.opt.syntax = "enable"
vim.cmd("filetype plugin on")

vim.opt.number = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.colorcolumn = "100"
vim.cmd("highlight ColorColumn ctermbg=236 guibg=#303030")

vim.opt.path:append("**")
vim.opt.wildmenu = true

vim.opt.splitbelow = true
