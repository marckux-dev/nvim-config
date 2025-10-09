
local function mark_to_delete_normal()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local block = { "// TO DELETE", "console.log();", "// END TO DELETE" }
  vim.api.nvim_buf_set_lines(0, row, row, false, block)
  vim.cmd("normal! jjf)a")
  vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("ToDelete", mark_to_delete_normal, { range = true })
