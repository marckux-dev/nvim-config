return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- ⚠️ CRÍTICO: Esta librería es obligatoria ahora
		"williamboman/mason.nvim", -- Para asegurar integración
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- 1. Configuración de la UI (Layouts por defecto)
		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
			mappings = {
				-- Atajos dentro de la ventana de debug
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},
			layouts = {
				{
					elements = {
						-- Elementos que aparecen a la izquierda
						{ id = "scopes", size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						-- Elementos que aparecen abajo (Consola y REPL)
						{ id = "repl", size = 0.5 },
						{ id = "console", size = 0.5 },
					},
					size = 10,
					position = "bottom",
				},
			},
			floating = {
				max_height = nil,
				max_width = nil,
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
			render = {
				max_type_length = nil,
			},
		})

		-- 2. Automatización: Abrir UI al iniciar debug, cerrar al terminar
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
--		dap.listeners.before.event_terminated.dapui_config = function()
--			dapui.close()
--		end
--		dap.listeners.before.event_exited.dapui_config = function()
--			dapui.close()
--		end

		-- 3. Atajos de teclado para Debugging
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug Continue (Start)" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle Debug UI" })
    vim.keymap.set("n", "<leader>dx", dapui.close, { desc = "Cerrar Debug UI" })
		vim.keymap.set("n", "<leader>dr", function()
			require("dap").repl.open()
		end, { desc = "Abrir REPL (Consola de salida)" })
	end,
}
--return {
--  "mfussenegger/nvim-dap",
--  dependencies = {
--    "rcasia/neotest-java",
--    "rcarriga/nvim-dap-ui",
--    "nvim-neotest/nvim-nio",
--  },
--  config = function ()
--    local dap = require("dap")
--    local dapui = require("dapui")
--    dapui.setup()
--    dap.listeners.after.event_intialized["dapui_config"] = function ()
--      dapui.open()
--    end
--    dap.listeners.before.event_terminated["dapui_config"] = function ()
--      dapui.close()
--    end
--    dap.listeners.before.event_exited["dapui_config"] = function ()
--      dapui.close()
--    end
--  end,
--  vim.keymap.set("n", "<leader>dc", function() require("dap").repl.open() end, { desc = "Abrir REPL (Consola de salida)" })
--}
