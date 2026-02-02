return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.add({
			{ "<leader>w", group = "Write / Save" },
			{ "<leader>b", group = "Buffers" },
			{ "<leader>f", group = "Files" },
			{ "<leader>c", group = "Catpuccin" },
			{ "<leader>e", group = "Error / Code" },
			{ "<leader>t", group = "Test" },
      { "<leader>d", group = "DAP"},
			-- Mappings para modo Visual
			{ "<leader>w", group = "Wrap selection", mode = "v" },
			-- Mappings para java
			{ "<leader>j", group = "Java / JDTLS" },
		})

		wk.setup({
			win = {
				border = "rounded",
			},
			layout = {
				spacing = 4,
			},
		})
	end,
}
