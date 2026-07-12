return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>am", "<cmd>Minuet virtualtext toggle<cr>", desc = "Toggle Minuet ghost text" },
    {
      "<leader>aM",
      function()
        vim.ui.select(vim.tbl_keys(require("minuet-providers").list()), {
          prompt = "Minuet provider:",
        }, function(choice)
          if choice then require("minuet-providers").apply(choice) end
        end)
      end,
      desc = "Elegir provider de Minuet",
    },
  },
  config = function()
    -- Configuración multi-provider: ver lua/minuet-providers.lua.
    -- Cambiar en caliente con :MinuetProvider <nombre> o <leader>aM.
    -- Default al arrancar: $MINUET_PROVIDER o "ollama".
    local mp = require("minuet-providers")

    vim.api.nvim_create_user_command("MinuetProvider", function(opts)
      mp.apply(opts.args)
    end, {
      nargs = 1,
      complete = function() return vim.tbl_keys(mp.list()) end,
      desc = "Cambiar provider de Minuet en caliente",
    })

    mp.apply(vim.env.MINUET_PROVIDER or "ollama")
  end,
}
