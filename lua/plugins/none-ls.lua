return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black.with({
					filetypes = { "python" },
					extra_args = { "--line-length", "88" },
				}),
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
					-- --prose-wrap always reflows long lines in Markdown/MDX
					-- (ignored by other filetypes); code fences are left untouched.
					extra_args = { "--print-width", "80", "--prose-wrap", "always" },
				}),
			},
		})
		vim.keymap.set("n", "<leader>ef", function()
			vim.lsp.buf.format()
		end, { desc = "Format file" })
	end,
}
