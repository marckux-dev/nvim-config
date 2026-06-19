return {
	"lervag/vimtex",
	lazy = false,
	ft = { "tex", "latex" },
	init = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			aux_dir = "",
			out_dir = "",
			callback = 1,
			continuous = 1,
			executable = "latexmk",
			options = {
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
				"-pdf",
			},
		}
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_mappings_enabled = 1
		vim.g.tex_flavor = "latex"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "tex", "latex" },
			callback = function()
				vim.schedule(function()
					vim.cmd("VimtexCompile")
				end)
				local opts = { buffer = true, silent = true }
				vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<cr>", vim.tbl_extend("force", opts, { desc = "VimTeX Compile toggle" }))
				vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<cr>", vim.tbl_extend("force", opts, { desc = "VimTeX View" }))
				vim.keymap.set("n", "<leader>ls", "<cmd>VimtexStop<cr>", vim.tbl_extend("force", opts, { desc = "VimTeX Stop" }))
				vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<cr>", vim.tbl_extend("force", opts, { desc = "VimTeX Clean" }))
				vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<cr>", vim.tbl_extend("force", opts, { desc = "VimTeX Errors" }))
				vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<cr>", vim.tbl_extend("force", opts, { desc = "VimTeX TOC" }))
			end,
		})
	end,
}
