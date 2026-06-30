-- ============================================================================
--  Emmet (mattn/emmet-vim)
-- ----------------------------------------------------------------------------
--  Aporta los atajos clásicos de Emmet (`<C-y>,` para expandir, `<C-y>,` en
--  modo visual para "wrap with abbreviation"). Convive con el servidor LSP
--  `emmet_language_server` (declarado en `lsp-config.lua`):
--
--    · emmet_language_server  →  autocompletado de abreviaturas dentro del
--                                popup de nvim-cmp.
--    · mattn/emmet-vim        →  expansión bajo demanda y, sobre todo, el
--                                comando "wrap with abbreviation" en visual,
--                                que en la práctica el LSP no expone como
--                                code action de forma fiable.
--
--  Lazy-load: sólo se carga al abrir un buffer con un filetype web. No tiene
--  coste en sesiones de Java, Python o Lua.
-- ============================================================================

return {
  "mattn/emmet-vim",

  -- Filetypes en los que Emmet tiene sentido. Añadir más aquí si se necesita
  -- (p. ej. "php", "twig", "markdown").
  ft = {
    "html",
    "css",
    "scss",
    "sass",
    "less",
    "astro",
    "vue",
    "svelte",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "xml",
  },

  init = function()
    -- Trigger key. Por defecto `<C-y>` — siempre se debe pulsar seguido de
    -- una segunda tecla (típicamente `,`) para confirmar la acción. Se deja
    -- el valor por defecto para no colisionar con `<leader>y` (clip.exe).
    vim.g.user_emmet_leader_key = "<C-y>"

    -- Modo "expand only": deshabilita los muchos atajos extra que registra
    -- emmet-vim (navegar entre tags, balancear, etc.) y conserva sólo el
    -- gesto principal `<C-y>,`. Mantiene la configuración predecible y
    -- evita choques con otras combinaciones.
    --   0 = todos los modos (defecto del plugin)
    --   1 = sólo modo normal
    --   2 = sólo modo insertar
    --   4 = sólo modo visual
    --   suma de bits = combinación
    -- 1 + 2 + 4 = 7  → activo en normal, insertar y visual (los tres modos
    -- relevantes para expandir o envolver).
    vim.g.user_emmet_mode = "a" -- "a" = all modes; equivalente a 7.

    -- Si quisiéramos JSX/TSX con clases en lugar de className al expandir,
    -- podríamos pasar `settings` aquí. Lo dejamos en defaults: ya detecta
    -- React por filetype.
  end,
}
