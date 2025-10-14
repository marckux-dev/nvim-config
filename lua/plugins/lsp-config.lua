return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"html",
					"cssls",
					"ts_ls",
					"angularls",
					"eslint",
          "jdtls",
					"tailwindcss",
					"lemminx",
					"yamlls",
					"jsonls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.enable("jdtls")
			vim.lsp.config("jdtls", {
        capabilities = capabilities,
				settings = {
					java = {},
				},
			})

			vim.lsp.enable("lua_ls")
			vim.lsp.config("lua_ls", {
        capabilities = capabilities,
				settings = {
					runtime = {
						version = "LuaJIT",
						path = vim.split(package.path, ";"),
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enalble = false,
					},
				},
			})

			vim.lsp.config("html", {
        capabilities = capabilities,
      })
			vim.lsp.config("cssls", {
        capabilities = capabilities,
      })
			vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })
			vim.lsp.config("angularls", {
        capabilities = capabilities,
      })
			vim.lsp.config("eslint", {
        capabilities = capabilities,
      })
			vim.lsp.config("lemminx", {
        capabilities = capabilities,
      })
			vim.lsp.config("yamlls", {
        capabilities = capabilities,
      })
			vim.lsp.config("jsonls", {
        capabilities = capabilities,
      })

			vim.lsp.enable("html")
			vim.lsp.enable("cssls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("angularls")
			vim.lsp.enable("eslint")
			vim.lsp.enable("lemminx")
			vim.lsp.enable("yamlls")
			vim.lsp.enable("jsonls")


			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
