return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>am", "<cmd>Minuet virtualtext toggle<cr>", desc = "Toggle Minuet ghost text" },
  },
  config = function()
    require("minuet").setup({
      request_timeout = 30,
      provider = "openai_fim_compatible",
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM",
          name = "Ollama",
          end_point = "http://localhost:11434/v1/completions",
          model = "qwen2.5-coder:7b",
          optional = {
            max_tokens = 56,
            top_p = 0.9,
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { "java", "python", "lua", "javascript", "typescript" },
        show_on_completion_menu = true,
        keymap = {
          accept        = "<M-y>",   -- Alt+y: aceptar sugerencia completa
          accept_line   = "<M-l>",   -- Alt+l: aceptar sólo la línea
          prev          = "<M-[>",
          next          = "<M-]>",
          dismiss       = "<M-e>",
        },
      },
    })
  end,
}
