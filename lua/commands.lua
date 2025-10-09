
-- Tags
vim.api.nvim_create_user_command("MakeTags", "!ctags -R", {})

-- Format HTML with Prettier
vim.api.nvim_create_user_command(
  "FormatHTML",
  "%!prettier --parser html --print-width=80",
  { range = true }
)

-- Angular Generator
vim.api.nvim_create_user_command("NgGen", function(opts)
  local args = opts.args
  local parts = vim.split(args, " ")
  vim.cmd("!ng generate " .. args)   -- Run Angular CLI
  if parts[2] then
    vim.cmd("find " .. parts[2] .. "*") -- Try to open generated file
  end
end, { nargs = "+" })
