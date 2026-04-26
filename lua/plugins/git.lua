return {
	-- Gitsigns: decoraciones en el gutter y operaciones sobre hunks
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local gs = require("gitsigns")

			gs.setup({
				signs = {
					add          = { text = "▎" },
					change       = { text = "▎" },
					delete       = { text = "" },
					topdelete    = { text = "" },
					changedelete = { text = "▎" },
					untracked    = { text = "▎" },
				},
				current_line_blame = false,
				current_line_blame_opts = { delay = 500 },
			})

			-- Navegación entre hunks  (<leader>gh = git hunk)
			vim.keymap.set("n", "<leader>ghn", gs.next_hunk,       { desc = "Siguiente hunk" })
			vim.keymap.set("n", "<leader>ghp", gs.prev_hunk,       { desc = "Hunk anterior" })
			-- Staging
			vim.keymap.set("n", "<leader>ghs", gs.stage_hunk,      { desc = "Stage hunk" })
			vim.keymap.set("v", "<leader>ghs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Stage hunk (selección)" })
			vim.keymap.set("n", "<leader>ghS", gs.stage_buffer,    { desc = "Stage buffer completo" })
			vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Deshacer stage hunk" })
			vim.keymap.set("n", "<leader>ghr", gs.reset_hunk,      { desc = "Resetear hunk" })
			vim.keymap.set("n", "<leader>ghR", gs.reset_buffer,    { desc = "Resetear buffer completo" })
			-- Información / Blame
			vim.keymap.set("n", "<leader>ghb", gs.blame_line,      { desc = "Blame línea actual" })
			vim.keymap.set("n", "<leader>ghB", function()
				gs.blame_line({ full = true })
			end, { desc = "Blame completo" })
			vim.keymap.set("n", "<leader>ghd", gs.diffthis,        { desc = "Diff contra index" })
			vim.keymap.set("n", "<leader>ghD", function()
				gs.diffthis("~")
			end, { desc = "Diff contra último commit" })
			-- Toggles  (<leader>gt = git toggle)
			vim.keymap.set("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle blame en línea" })
			vim.keymap.set("n", "<leader>gtd", gs.toggle_deleted,            { desc = "Toggle mostrar eliminados" })
		end,
	},

	-- Vim Fugitive: integración completa con Git
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete" },
		keys = {
			{ "<leader>gg",  "<cmd>Git<CR>",               desc = "Git status (Fugitive)" },
			{ "<leader>gc",  "<cmd>Git commit<CR>",        desc = "Git commit" },
			{ "<leader>gl",  "<cmd>Git log --oneline<CR>", desc = "Git log (oneline)" },
			{ "<leader>gL",  "<cmd>Git log<CR>",           desc = "Git log completo" },
			{ "<leader>gpp", "<cmd>Git push<CR>",          desc = "Git push" },
			{ "<leader>gpl", "<cmd>Git pull<CR>",          desc = "Git pull" },
			{ "<leader>gfe", "<cmd>Git fetch<CR>",         desc = "Git fetch" },
			{ "<leader>gw",  "<cmd>Gwrite<CR>",            desc = "Git add (archivo actual)" },
			{ "<leader>gde", "<cmd>Gdiffsplit<CR>",        desc = "Git diff split" },
		},
	},
}
