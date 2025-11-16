return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
    keys = {
      {"<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files"},
      {"<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live grep"},

    },
		config = function()
			local builtin = require("telescope.builtin")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
