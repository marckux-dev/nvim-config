return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.register({
			w = {
				name = "Write / Save",
			},
			b = {
				name = "Buffers",
			},
			f = {
				name = "Files",
			},
			c = {
				name = "Catpuccin",
			},
			n = {
				name = "Neotree",
			},
			e = {
				name = "Error",
			},
			t = {
				name = "Test",
			},
		}, { prefix = "<leader>", mode = "n" })
		wk.register({
			w = {
				name = "Wrap selection",
			},
		}, { prefix = "<leader>", mode = "v" })
		wk.setup({
			window = {
				border = "rounded",
			},
			layout = {
				spacing = 4,
			},
			show_help = true,
		})
	end,
}
