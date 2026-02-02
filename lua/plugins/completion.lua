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

      -- Configuración del diccionario de texto plano
      require("cmp_dictionary").setup({
        paths = { vim.fn.expand("~/.config/nvim/spell/obsidian-es.utf-8.add") },
        exact_length = 2,
        first_case_insensitive = true,
      })

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            else fallback() end
          end, { "i", "s" }),
        }),
        -- Definición de prioridades (1. Buffer, 2. Otros Buffers, 3. Diccionario propio)
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
          { name = "dictionary", priority = 250 }, -- ✨ Tu obsidian-es.utf-8.add
          { name = "path",       priority = 100 },
        }),
      })
    end,
  },
}
-- VERSION ANTERIOR
-- return {
-- 	-- Main completion engine
-- 	{
-- 		"hrsh7th/nvim-cmp",
-- 		event = "InsertEnter",
-- 		dependencies = {
-- 			-- LSP completions
-- 			"hrsh7th/cmp-nvim-lsp",
-- 			-- Buffer words
-- 			"hrsh7th/cmp-buffer",
-- 			-- Filesystem paths
-- 			"hrsh7th/cmp-path",
-- 			-- Snippets
-- 			"L3MON4D3/LuaSnip",
-- 			"saadparwaiz1/cmp_luasnip",
-- 			-- Snippet collection
-- 			"rafamadriz/friendly-snippets",
-- 			"f3fora/cmp-spell", -- ✨ Nueva dependencia para el diccionario/spell
-- 		},
-- 		config = function()
-- 			local cmp = require("cmp")
-- 			local luasnip = require("luasnip")
-- 
-- 			-- Load VSCode-style snippets
-- 			require("luasnip.loaders.from_vscode").lazy_load()
-- 
-- 			cmp.setup({
-- 				snippet = {
-- 					expand = function(args)
-- 						luasnip.lsp_expand(args.body)
-- 					end,
-- 				},
-- 				mapping = cmp.mapping.preset.insert({
-- 					["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 					["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 					["<C-Space>"] = cmp.mapping.complete(),
-- 					["<C-e>"] = cmp.mapping.abort(),
-- 					["<CR>"] = cmp.mapping.confirm({ select = true }),
-- 					["<Tab>"] = cmp.mapping(function(fallback)
-- 						if cmp.visible() then
-- 							cmp.select_next_item()
-- 						elseif luasnip.expand_or_jumpable() then
-- 							luasnip.expand_or_jump()
-- 						else
-- 							fallback()
-- 						end
-- 					end, { "i", "s" }),
-- 					["<S-Tab>"] = cmp.mapping(function(fallback)
-- 						if cmp.visible() then
-- 							cmp.select_prev_item()
-- 						elseif luasnip.jumpable(-1) then
-- 							luasnip.jump(-1)
-- 						else
-- 							fallback()
-- 						end
-- 					end, { "i", "s" }),
-- 				}),
-- 				sources = cmp.config.sources({
-- 					{ name = "nvim_lsp" },
-- 					{ name = "luasnip" },
-- 					{ name = "buffer" },
-- 					{ name = "path" },
-- 					{
-- 						name = "spell",
-- 						priority = 100,
-- 						keyword_length = 3,
-- 						option = {
-- 							keep_all_entries = false,
-- 							enable_in_context = function()
-- 								return true
-- 							end,
-- 						},
-- 					}, -- Esto activa las palabras del diccionario
-- 				}),
-- 				window = {
-- 					completion = cmp.config.window.bordered(),
-- 					documentation = cmp.config.window.bordered(),
-- 				},
-- 			})
-- 		end,
-- 	},
-- }
