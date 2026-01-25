-- https://github.com/nvim-flutter/flutter-tools.nvim
return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
		"hrsh7th/cmp-nvim-lsp", -- necesario para el autocompletado
	},
	config = function()
		-- ============================================================
		-- SISTEMA DE HOT RELOAD DINÁMICO (TMUX)
		-- ============================================================
		local M = {
			active = false,
			pane = ".+", -- Por defecto: el panel de al lado
		}

		-- Comando :FlutterWatch [pane]
		vim.api.nvim_create_user_command("FlutterWatch", function(opts)
			if opts.args ~= "" then
				M.pane = opts.args
				M.active = true
				print("🚀 Flutter Watch ACTIVADO -> Panel: " .. M.pane)
			else
				M.active = not M.active
				local status = M.active and "ACTIVADO" or "DESACTIVADO"
				print("📡 Flutter Watch " .. status .. " (Panel: " .. M.pane .. ")")
			end
		end, { nargs = "?" })

		-- Autocomando para detectar guardado
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*.dart",
			callback = function()
				if M.active then
					-- Enviamos la 'r' de hot reload a tmux
					local command = string.format("tmux send-keys -t %s r", M.pane)
					vim.fn.system(command)
				end
			end,
		})
		-- ============================================================
		-- Obtener capabilities
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- Configurar el plugin
		require("flutter-tools").setup({
			ui = {
				border = "rounded", -- Borde de las ventanas flotantes
				notification_style = "plugin", -- Agregar notificaciones al abrir proyectos
			},
			decorations = {
				statusline = {
					app_version = true,
					device = true,
				},
			},
			widget_guides = {
				enabled = true,
			}, -- Habilitar "Widget guides" al estilo VSCode
			lsp = {
				capabilities = capabilities,
				-- Configuración específica para Dart
				settings = {
					showTodos = true,
					completeFuctionCalls = true,
					renameFilesWithClasses = "prompt", -- Preguntar si renombrar clase al renombrar archivo
					enableSnipets = true,
				},
				-- Atajos de teclado sólo para Dart / Flutter
				on_attach = function(client, bufnr)
					local opts = { buffer = bufnr }
					-- Atajos estándar de LSP
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set(
						"n",
						"<leader>ee",
						vim.diagnostic.open_float,
						{ desc = "Show Diagnostic", buffer = bufnr }
					)

					-- Atajos específicos de Flutter
					vim.keymap.set(
						"n",
						"<leader>FR",
						":FlutterRestart<CR>",
						{ desc = "Flutter Hot Restart", buffer = bufnr }
					)
					vim.keymap.set(
						"n",
						"<leader>FD",
						":FlutterDevices<CR>",
						{ desc = "Flutter Devices", buffer = bufnr }
					)
					vim.keymap.set(
						"n",
						"<leader>FO",
						":FlutterOutlineToggle<CR>",
						{ desc = "Flutter Outline", buffer = bufnr }
					)
				end,
			},
		})
		require("telescope").load_extension("flutter")
	end,
}
