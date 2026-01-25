return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"html",
					"cssls",
					"ts_ls",
					"angularls",
					"eslint",
					"jdtls", -- Keep this here so Mason installs it
					"tailwindcss",
					"lemminx",
					"yamlls",
					"jsonls",
					"astro",
					"rust_analyzer",
				},

				handlers = {
					-- Default handler for all servers *except* jdtls and lua_ls
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,

					-- Custom handler for lua_ls (as in your old config)
					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "LuaJIT" },
									diagnostics = { globals = { "vim" } },
									workspace = { checkThirdParty = false },
								},
							},
						})
					end,

					-- Custom handler for jdtls: DO NOTHING.
					-- This prevents mason-lspconfig from starting it.
					-- nvim-jdtls (in its own file) will handle it.
					["jdtls"] = function()
						-- Intentionally empty
					end,
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ea", vim.lsp.buf.code_action, { desc = "Code Actions" })
			vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float, { desc = "Show Diagnostic" })
		end,
	},
}
