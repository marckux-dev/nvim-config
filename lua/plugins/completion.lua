-- path: ./lua/plugins/completion.lua
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      -- ✨ Plugin para usar archivos de texto como diccionarios puros
      "uga-rosa/cmp-dictionary", 
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      -- Completion para buffers de vim-dadbod-ui (SQL queries)
      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = cmp.config.sources({
          { name = "vim-dadbod-completion", priority = 1000 },
          { name = "nvim_lsp",             priority = 800 },
          { name = "luasnip",              priority = 750 },
          { name = "buffer",               priority = 500 },
        }),
      })

      -- Configuración del diccionario de texto plano
      require("cmp_dictionary").setup({
        paths = { vim.fn.expand("~/.config/nvim/spell/obsidian-es.utf-8.add") },
        exact_length = 2,
        first_case_insensitive = true,
      })

      -- En markdown: añadir el diccionario Obsidian al popup.
      -- Fuera de markdown lo dejamos fuera para que no contamine los
      -- completados de LSP en código (p. ej. abreviaturas Emmet en .ts/.html
      -- quedaban sepultadas por entradas españolas con prefijo similar).
      cmp.setup.filetype("markdown", {
        sources = cmp.config.sources({
          { name = "nvim_lsp",   priority = 1000 },
          { name = "luasnip",    priority = 750 },
          { name = "buffer",     priority = 500 },
          { name = "dictionary", priority = 250 },
          { name = "path",       priority = 100 },
        }),
      })

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = function(entry, item)
            item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip  = "[Snip]",
              buffer   = "[Buf]",
              path     = "[Path]",
              dictionary = "[Dict]",
              ["vim-dadbod-completion"] = "[DB]",
            })[entry.source.name]
            return item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            else fallback() end
          end, { "i", "s" }),
        }),
        -- Definición de prioridades (1. Buffer, 2. Otros Buffers)
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 750 },
          {
            name = "buffer",
            priority = 500,
            option = {
              -- Leer palabras de todos los buffers abiertos (Prioridad 2)
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            }
          },
          { name = "path",       priority = 100 },
        }),
      })
    end,
  },
}
