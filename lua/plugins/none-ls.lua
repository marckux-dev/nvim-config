return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"javascript",
						"typescript",
						"html",
						"css",
						"json",
						"markdown",
						"astro",
						"yaml",
					},
					extra_args = { "--print-width", "80" },
				}),
			},
		})
		vim.keymap.set("n", "<leader>s", function()
			vim.lsp.buf.format()
			vim.notify("File formatted with Prettier (none-ls)")
		end, { desc = "Styling"})
	end,
}
