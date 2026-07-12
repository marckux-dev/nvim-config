-- Definición de providers para minuet-ai y switching en caliente.
-- Añadir un provider nuevo = añadir una entrada a `providers` con el bloque
-- `provider`/`provider_options` que pide minuet. El resto (virtualtext,
-- keymaps, timeout) es común y se mergea en apply().

local M = {}

local providers = {
  ollama = {
    provider = "openai_fim_compatible",
    provider_options = {
      openai_fim_compatible = {
        -- Ollama no necesita key, pero minuet exige que la env var exista;
        -- TERM está siempre definida.
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
  },
  gemini = {
    provider = "gemini",
    provider_options = {
      gemini = {
        model = "gemini-2.5-flash",
        -- Nombre de la env var con la clave, no la clave.
        api_key = "GEMINI_API_KEY",
      },
    },
  },
}

local common = {
  request_timeout = 30,
  virtualtext = {
    auto_trigger_ft = { "java", "python", "lua", "javascript", "typescript" },
    -- CRÍTICO: sin esto minuet no dispara mientras nvim-cmp muestra popup.
    show_on_completion_menu = true,
    keymap = {
      accept      = "<M-y>", -- Alt+y: aceptar sugerencia completa
      accept_line = "<M-l>", -- Alt+l: aceptar sólo la línea
      prev        = "<M-[>",
      next        = "<M-]>",
      dismiss     = "<M-e>",
    },
  },
}

function M.list()
  return providers
end

function M.apply(name)
  local p = providers[name]
  if not p then
    vim.notify("Minuet: provider desconocido '" .. name .. "'", vim.log.levels.ERROR)
    return
  end
  require("minuet").setup(vim.tbl_deep_extend("force", common, p))
  -- setup() registra el auto-trigger vía autocmd FileType, que no vuelve a
  -- dispararse en buffers ya abiertos: reactivarlo a mano en ellos.
  local ft_set = {}
  for _, ft in ipairs(common.virtualtext.auto_trigger_ft) do
    ft_set[ft] = true
  end
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and ft_set[vim.bo[buf].filetype] then
      vim.b[buf].minuet_virtual_text_auto_trigger = true
    end
  end
  M.current = name
  vim.notify("Minuet → " .. name)
end

return M
