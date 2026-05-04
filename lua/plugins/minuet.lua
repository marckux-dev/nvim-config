return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("minuet").setup({
      provider = "gemini",
      provider_options = {
        gemini = {
          model = "gemini-2.5-flash",
          api_key = "GEMINI_API_KEY",
        },
      },
      virtualtext = {
        auto_trigger_ft = { "java", "python", "lua", "javascript", "typescript" },
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
