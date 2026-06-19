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
			{ "<leader>d", group = "DAP" },
			{ "<leader>g",   group = "Git" },
			{ "<leader>gh",  group = "Git hunks" },
			{ "<leader>gt",  group = "Git toggles" },
			{ "<leader>gp",  group = "Git push/pull" },
			{ "<leader>gf",  group = "Git fetch" },
			-- Mappings para modo Visual
			{ "<leader>w", group = "Wrap selection", mode = "v" },
			{ "<leader>g", group = "Git (visual)", mode = "v" },
			-- Mappings para java
			{ "<leader>j", group = "Java / JDTLS" },
			{ "<leader>J", group = "Jupyter" },
			{ "<leader>D", group = "Database (dadbod)" },
			{ "<leader>l", group = "LaTeX (VimTeX)" },
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
