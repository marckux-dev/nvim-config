return {
  {
    "tpope/vim-dadbod",
    lazy = true,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.expand("~/.local/share/db_ui")
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1
      vim.g.db_ui_execute_on_save = 0

      vim.keymap.set("n", "<leader>Do", "<cmd>DBUIToggle<CR>",        { desc = "Toggle DB UI" })
      vim.keymap.set("n", "<leader>Da", "<cmd>DBUIAddConnection<CR>", { desc = "Add DB connection" })
      vim.keymap.set("n", "<leader>Df", "<cmd>DBUIFindBuffer<CR>",    { desc = "Find DB buffer" })
    end,
  },
}
